class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  include Canable::Cans
  
  before_save :set_sortable_scores
  
  Roles = %w{student professor gsi admin}
  
  attr_accessor :remember_me
  attr_accessible :username, :email, :crypted_password, :remember_me_token,
    :avatar_file_name, :role, :first_name, :last_name, :rank, :course_id,
    :user_id, :display_name, :private_display, :default_course_id,
    :last_activity_at, :last_login_at, :last_logout_at, :team_ids, :course_ids,
    :shared_badges, :earned_badges, :earned_badges_attributes

  scope :alpha, -> lambda { where order: 'last_name ASC' }
  scope :winning, -> lambda { where order: 'course_memberships.sortable_score DESC' }
  
  has_many :course_memberships
  has_many :courses, :through => :course_memberships, :uniq => true 
  accepts_nested_attributes_for :courses
  belongs_to :default_course, :class_name => 'Course'
  has_many :grades, :as => :gradeable, :dependent => :destroy
  has_many :user_assignment_type_weights
  has_many :assignments, :through => :grades
  has_many :assignment_submissions, :as => :submittable, :dependent => :destroy
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  accepts_nested_attributes_for :earned_badges, :reject_if => proc { |attributes| attributes['earned'] != '1' }

  has_many :badges, :through => :earned_badges
  has_many :team_memberships, :dependent => :destroy
  has_many :teams, :through => :team_memberships
  has_many :group_memberships, :dependent => :destroy
  has_many :groups, :through => :group_memberships, :uniq => true 
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
  
  def earned_grades(course)
    (course.grades_for_student(self).map(&:score).sum) 
    
    #(course.grades_for_student(self).map(&:score).sum) + earned_badges_value(course) + team_score(course)
  end

  def grades_by_assignment_id
    @grades_by_assignment ||= grades.group_by(&:assignment_id)
  end

  def grade_for_assignment(assignment)
    grades_by_assignment_id[assignment.id].try(:first)
  end
  
  #Badges

  def earned_badges_value(course)
    earned_badges.map(&:point_value).sum
  end
  
  def user_badge_count
    earned_badges.count
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
  
  def assignment_type_score(assignment_type)
    grades.select { |g| g.assignment.assignment_type_id == assignment_type.id }.map { |g| g.score(self) }.sum || 0 
  end
  
  
  def assignment_type_multiplier(assignment_type)
    (weights_for_assignment_type_id(assignment_type).try(:value) || 0.5)
  end
  
  #Score
  def sortable_score
    super || 0
  end
  
  #Import Users
  def self.csv_header
    "First Name,Last Name,Email,Username".split(',')
  end
  
  #Export Users and Final Scores
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["First Name", "Last Name", "Email", "Score", "Grade", "Logins", "Pageviews", "Predictor Views"]
      students.each do |user|
        csv << [user.first_name, user.last_name, user.email, user.earned_grades(course), user.grade_level(course), user.visit_count, user.page_views, user.predictor_views]
      end
    end
  end
  
  #Export Users and Final Scores for Course
  def self.csv_for_course(course, options = {})
    CSV.generate(options) do |csv|
      csv << ["First Name", "Last Name", "Email", "Score", "Grade", "Logins", "Pageviews", "Predictor Views"]
      course.users.students.each do |user|
        csv << [user.first_name, user.last_name, user.email, user.earned_grades(course), user.grade_level(course), user.visit_count, user.page_views, user.predictor_views]
      end
    end
  end
  
  #Calculates the total points available in a course, assuming that badges act as extra credit 
  def total_points_for_course(course, in_progress = false)
    course.total_points(in_progress) + earned_badges_value(course)
  end
  
  def grade_score(course)
    course.grades_for_student(self).map { |g| g.score(self) }.sum || 0
  end
  
  def team_score(course)
    teams.where(:course_id => course.id).first.try(&:score) || 0
  end
  
  def earned_grades(course)
    grade_score(course) + earned_badges_value(course) || 0
  end
  
  def group_for_assignment(assignment)
    groups.where(:assignment_id => assignment.id).first
  end

  private
  
  def set_sortable_scores
    course_memberships.each do |course_membership|
      course_membership.update_attribute(:sortable_score, self.earned_grades(course_membership.course))
    end
  end

end
