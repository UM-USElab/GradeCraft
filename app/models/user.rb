class User < ActiveRecord::Base
  authenticates_with_sorcery!

  Roles = %w{student professor gsi admin}
  
  attr_accessor :remember_me
  attr_accessible :username, :email, :crypted_password, :remember_me_token, :avatar_file_name, :role, :team_id, :first_name, :last_name, :sortable_score, :rank, :course_ids, :user_id, :display_name, :private_display, :default_course_id

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" },
                    :url => '/assets/avatars/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/avatars/:id/:style/:basename.:extension',
                    :default_url => '/images/missing_:style.png'
  default_scope :order => 'last_name ASC'
  scope :winning, :order => 'sortable_score DESC'
  
  has_many :course_memberships, :dependent => :destroy
  has_many :courses, :through => :course_memberships
  accepts_nested_attributes_for :courses          
  has_many :grades, :dependent => :destroy, :as => :graded
  has_many :assignments, :through => :grades
  has_many :earned_badges, :through => :grades
  has_many :badges, :through => :earned_badges
  belongs_to :team
  has_many :group_memberships, :dependent => :destroy
  has_many :groups, :through => :group_memberships

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
    @name = [first_name,last_name].reject(&:blank?).join(' ').presence || "User #{id}"
  end
  
  def public_name
    if display_name?
      display_name
    else 
      name
    end
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
  
  # TODO
  def assignment_type_score
    grades.assignment_type.sum(:score) || 0
  end
   
  def score
    grades.map(&:score).inject(&:+) || 0
  end
  
  def sortable_score
    grades.map(&:score).inject(&:+) || 0 
  end
  
  def rank
    
  end
  
  def alpha
  
  end
  
  def user_badge_count
    earned_badges.count
  end

  def team_badges
    team.try(:earned_badges) || []
  end
  
  def find_scoped_courses(course_id)
    course_id = BSON::ObjectId(course_id) if course_id.is_a?(String)
    if is_admin? || self.course_ids.include?(course_id)
      Course.find(course_id)
    else
      raise 
    end
  end
  
  def default_course
    @default_course ||= (self.courses.where(:id => self.default_course_id).first || self.courses.first)
  end

  def assignment_type_score_possible
    grades.where(:type => "").map(&:points_possible).inject(&:+) || 0
  end

  def possible_score
    assignment_type_score_possible || 0
  end

  def team_assignment_score
    0 # TODO: Remove this or make it calculate score
  end
 
  def team_leader
    team.try(:team_leader)
  end

  
  def attendance_rate
    #attendance_grade /attendance_dates.count TODO
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["First Name", "Last Name", "Score"]
      students.each do |user|
        csv << [user.first_name, user.last_name, user.sortable_score]
      end
    end
  end


end
