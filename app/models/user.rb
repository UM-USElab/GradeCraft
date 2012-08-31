class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  before_save :set_sortable_score
  
  Roles = %w{student professor gsi admin}
  
  attr_accessor :remember_me
  attr_accessible :username, :email, :crypted_password, :remember_me_token, :avatar_file_name, :role, :team_id, :first_name, :last_name, :rank, :course_id, :user_id, :display_name, :private_display, :default_course_id

  scope :alpha, :order => 'last_name ASC'
  scope :winning, :order => 'sortable_score DESC'
  
  has_and_belongs_to_many :courses, :join_table => :course_memberships, :uniq => true
  accepts_nested_attributes_for :courses          
  has_many :grades, :as => :gradeable, :dependent => :destroy
  has_many :user_assignment_type_weights
  has_many :assignments, :through => :grades
  has_many :assignment_submissions
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  belongs_to :team
  has_many :group_memberships, :dependent => :destroy
  has_many :groups, :through => :group_memberships
  
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
    team.try(:team_leader)
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
  
  def earned_grades
    grades + team.grades + group.grades + badge.values
  end

  def grades_by_assignment_id
    @grades_by_assignment ||= grades.group_by(&:assignment_id)
  end

  def grade_for_assignment(assignment)
    grades_by_assignment_id[assignment.id].try(:first)
  end
  
  #Score
  def sortable_score
    super || 0
  end

  def score
    grades.map(&:score).inject(&:+) || 0
  end
  
  #TODO CHECK
  def assignment_type_score(assignment_type)
    grades.select { |g| g.assignment.assignment_type_id == assignment_type.id }.map(&:raw_score).inject(&:+) || 0 
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
  
  #Export Users and Final Scores [need to add final grade]
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["First Name", "Last Name", "Score"]
      students.each do |user|
        csv << [user.first_name, user.last_name, user.sortable_score]
      end
    end
  end

  def possible_score
    assignments.map(&:point_total).inject(&:+) || 0
  end

  # Same with this
  def team_assignment_score
    0
  end
  
  private

  def set_sortable_score
    self.sortable_score = grades.reload.map(&:score).inject(&:+) || 0
  end

end
