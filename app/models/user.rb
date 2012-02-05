class User < ActiveRecord::Base
  authenticates_with_sorcery!

  Roles = %w{student professor gsi admin}

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" },
                    :url => '/assets/avatars/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/avatars/:id/:style/:basename.:extension',
                    :default_url => '/images/missing_:style.png'


  has_many :grades
  has_many :earned_badges, :through => :grades
  belongs_to :team

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates :username, :presence => true,
                    :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }


  %w{student gsi professor admin}.each do |role|
    scope role.pluralize, where(:role => role)
  end

  def name
    [first_name,last_name].join(' ')
  end

  def is_prof?
    role == "professor"
  end

  def is_gsi?
    role == "gsi"
  end

  def is_student?
    role == "student" || role.blank?
  end

  def is_admin?
    role == "admin"
  end

  def role
    super || "student"
  end

  def is_staff?
    is_prof? || is_gsi? || is_admin?
  end

  
  def standard_score
    grades.standard.sum(:score)
  end
  
  def standard_possible
    grades.standard.assignments.sum(:point_total) #get grades that are of type standard and have been attempted, find their assignment and get the point_total
  end
  
  def blogging_score
    grades.blogging.sum(:score)
  end
  
  def attendance_score
    grades.attendance.sum(:score)
  end
  
  def attendance_possible
    #if assignments.attendance.due_date < today 
  end
  
  def reading_reaction_score
    grades.reading_reaction.sum(:score)
  end
  
  def reading_reaction_possible
    #sum the total number of reading reactions that have happened so far
  end
    
  def calculate_score
    grades.sum(:score)
  end
  
  def possible_score
    #attendance_possible + reading_reaction_possible + standard_possible
  end
  
end
