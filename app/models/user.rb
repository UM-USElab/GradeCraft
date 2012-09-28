class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  include Canable::Cans
  
  before_save :set_sortable_score
  
  Roles = %w{student professor gsi admin}
  
  attr_accessor :remember_me
  attr_accessible :username, :email, :crypted_password, :remember_me_token, :avatar_file_name, :role, :first_name, :last_name, :rank, :course_id, :user_id, :display_name, :private_display, :default_course_id, :last_activity_at, :last_login_at, :last_logout_at, :team_ids, :course_ids

  scope :alpha, :order => 'last_name ASC'
  scope :winning, :order => 'sortable_score DESC'
  
  has_and_belongs_to_many :courses, :join_table => :course_memberships, :uniq => true
  accepts_nested_attributes_for :courses      
  has_many :grades, :as => :gradeable, :dependent => :destroy
  has_many :user_assignment_type_weights
  has_many :assignments, :through => :grades
  has_many :assignment_submissions, :as => :submittable, :dependent => :destroy
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  has_many :team_memberships, :dependent => :destroy
  has_many :teams, :through => :team_memberships
  has_many :group_memberships, :dependent => :destroy
  has_many :groups, :through => :group_memberships
  has_many :user_assignment_type_weights
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  #validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates :username, :presence => true,
                    :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  #Course
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
  
  #Names
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
  
  def team_leader
    teams.first.try(:team_leader)
  end

  #Roles
  %w{student gsi professor admin}.each do |role|
    scope role.pluralize, where(:role => role)
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
  
  #Grades

  def grade_level(course)
    course.grade_level(self)
  end
  
  def team_score(course)
    teams.where(:course_id => course.id).first.try(&:sortable_score) || 0
  end
  
  def group_grades
    
  end
  
  def earned_badges_value(course)
    #earned_badges.where(:course_id => course.id).map(&:point_value).sum
    earned_badges.map(&:point_value).sum
  end
 
  def earned_grades(course)
    (course.grades_for_student(self).map(&:score).sum) + earned_badges_value(course) + team_score(course)
  end

  def grades_by_assignment_id
    @grades_by_assignment ||= grades.group_by(&:assignment_id)
  end

  def grade_for_assignment(assignment)
    grades_by_assignment_id[assignment.id].try(:first)
  end

  def earnable
    @user.earned_badges.all 
  end

  def earned_badges_by_badge_id
    @earned_badges_by_badge ||= earned_badges.group_by(&:badge_id)
  end

  def earned_badges_by_badge(badge)
    earned_badges_by_badge_id[badge.id].try(:first)
  end
  
  def weights_by_assignment_type_id
    @weights_by_assignment_type_id ||= user_assignment_type_weights.group_by(&:assignment_type_id)
  end
  
  def weights_for_assignment_type_id(assignment_type)
    weights_by_assignment_type_id[assignment_type.id].try(:first)
  end

  #Score
  def sortable_score
    super || 0
  end

  def score
    grades.map(&:score).inject(&:+) || 0
  end

  def assignment_type_score(assignment_type)
    grades.select { |g| g.assignment.assignment_type_id == assignment_type.id }.map(&:score).inject(&:+) || 0 
  end

  def attendance_rate
    #(attendance_grade /assignments(type => attendance).count)*100 TODO
  end
  
  #Status
  
  #Badges
  def user_badge_count
    earned_badges.count
  end

  def team_badges
    team.try(:earned_badges) || []
  end
  
  #Import Users
  def self.csv_header
    "First Name,Last Name,Email,Username".split(',')
  end

  
  #Export Users and Final Scores [TODO need to add final grade]
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["First Name", "Last Name", "Score"]
      students.each do |user|
        csv << [user.first_name, user.last_name, user.sortable_score]
      end
    end
  end

  # Putting this here just so things don't break... remove if needed.

  def possible_score
    assignments.map(&:point_total).inject(&:+) || 0
  end

  # Same with this
  def team_assignment_score
    0
  end
  
  def total_points_for_course(course, in_progress = false)
    course.total_points(in_progress) + earned_badges_value(course)
  end

  private

  def set_sortable_score
    self.sortable_score = grades.reload.map(&:score).inject(&:+) || 0
  end

end
