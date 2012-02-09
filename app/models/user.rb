class User < ActiveRecord::Base
  authenticates_with_sorcery!

  Roles = %w{student professor gsi admin}

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" },
                    :url => '/assets/avatars/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/avatars/:id/:style/:basename.:extension',
                    :default_url => '/images/missing_:style.png'


  has_many :grades, :dependent => :destroy
  has_many :earned_badges, :through => :grades
  belongs_to :team
  
  default_scope :order => 'last_name ASC'

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

  #Actual
  def standard_score
    grades.standard.sum(:score) || 0
  end
  
  
  def blogging_score
    grades.blogging.map(&:score).inject(&:+) || 0
  end
  
  def attendance_score
    grades.attendance.sum(:score) || 0
  end
  
  def reading_reaction_score
    grades.reading_reaction.map(&:score).inject(&:+) || 0
  end
   
  def score
    grades.map(&:score).inject(&:+) || 0
  end
  
  #Possible 
  def reading_reaction_possible
    grades.where(:type=>"ReadingReactionGrade").map(&:points_possible).inject(&:+) || 0
  end
    
  def standard_possible
    grades.where(:type=>"StandardGrade").map(&:points_possible).inject(&:+) || 0
  end
  
  def attendance_possible
    grades.where(:type=>"AttendanceGrade").map(&:points_possible).inject(&:+) || 0
  end
  
  def possible_score
    attendance_possible + reading_reaction_possible + standard_possible || 0
  end
  
end
