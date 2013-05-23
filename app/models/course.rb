class Course < ActiveRecord::Base
  attr_accessible :badge_set_ids, :course_grade_scheme_id, :courseno, :name, :semester, :theme_id, :year, :badge_setting, :team_setting, :team_term, :user_term, :user_id, :course_id, :homepage_message, :group_setting, :user_weight_amount, :user_weight_amount_close_date, :team_roles, :section_leader_term, :group_term, :user_weight_amount_type, :has_assignment_submissions, :teams_visible, :badge_use_scope, :multiplier_default, :multiplier_term, :badges_value, :predictor_setting, :max_group_size, :min_group_size, :shared_badges, :graph_display, :assignments, :theme
  
  has_many :course_memberships
  has_many :users, :through => :course_memberships
  accepts_nested_attributes_for :users
  
  has_many :assignments, :dependent => :destroy
  has_many :assignment_types, :dependent => :destroy
  has_many :assignment_submissions, :through => :assignments
  has_and_belongs_to_many :badge_sets, :join_table => :course_badge_sets
  has_many :badges, :through => :badge_sets
  has_many :earned_badges, :through => :users
  has_many :grade_schemes, :dependent => :destroy
  has_many :grade_scheme_elements, :through => :grade_schemes
  belongs_to :course_grade_scheme
  has_many :course_grade_scheme_elements, :through => :course_grade_scheme
  has_many :grades, :through => :assignments
  has_many :groups, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :team_assignments, :dependent => :destroy
  belongs_to :theme
  
  #Validations
  validates_presence_of :name, :badge_setting, :team_setting, :group_setting
  
  #Terms
  def user_term
    super || "Player"
  end
  
  def team_term
    super || "Team"
  end
  
  def group_term
    super || "Group"
  end
  
  def section_leader_term
    super || "Team Leader"
  end
  
  def multiplier_term
    super || "Multiplier"
  end
  
  #Conditions
  def has_teams?
    team_setting == true
  end
  
  def graph_display?
    graph_display == true
  end
  
  #Can students see the team scores?
  def teams_visible?
    teams_visible == true
  end
  
  #Does the course use badges
  def has_badges?
    badge_setting == true
  end

  #Do badges count towards the course grade?  
  def valuable_badges?
    badges_value == true 
  end
  
  #Can students access the predictor?
  def predictor_on?
    predictor_setting == true
  end
  
  #Does the course have assignments that are graded at a group scope?
  def has_groups?
    group_setting == true
  end

  #Are badges assigned outside of assignments?
  def course_badges? 
    badge_use_scope == "Course"
  end
  
  #Are badges assigned only in assignments?
  def assignment_badges? 
    badge_use_scope == "Assignment"
  end
  
  #Are badges assigned both inside and outside of assignments?
  def multi_badges? 
    badge_use_scope == "Both"
  end
  
  #Can students see other students' badges?
  def shared_badges?
    shared_badges == true
  end

  #Can students decide assignment values? 
  def student_weighted? 
    user_weight_amount != nil 
  end
  
  #Do students declare their roles on their team within the system?
  def team_roles?
    team_roles == true
  end

  #Will GradeCraft be used to accept assignment submissions?   
  def has_assignment_submissions? 
    has_assignment_submissions == true
  end

  def membership_for_student(student)
    course_memberships.detect { |m| m.user_id == student.id }
  end

  def total_points(in_progress = false)
    (in_progress ? assignments.past : assignments).to_a.sum(&:point_total)
  end

  def running_total_points
    assignments.past.map { |assignment| assignment.point_total_for_student(student) }.sum
  end
  
  def total_for_student(student)
    assignments.map { |assignment| assignment.point_total_for_student(student) }.sum
  end
  
  #How much are badges worth throughout the course?
  def badge_total
    badges.sum(:value)
  end
  
  def score_for_student(student)
   student.earned_grades(self)
  end

  

  #What course grade has the student achieved? 
  def grade_level(student)
    course_grade_scheme.try(:grade_level, score_for_student(student)) || "Not yet known"
  end
  
  
  def group_grades_for_student(student)
    grades = []
    student.groups.each do |group|
      grades += self.grades.where(:gradeable => group)
    end
    grades
  end
  
  def individual_grades_for_student(student)
    self.grades.where(:gradeable => student)
  end
  
  def team_grades_for_student(student)
    self.grades.where(:gradeable => student.teams.first)
  end
  
  def grades_for_student(student)
    individual_grades_for_student(student) + ((group_grades_for_student(student) if student.groups.present?) || []) 
    #individual_grades_for_student(student) + team_grades_for_student(student) + ((group_grades_for_student(student) if student.groups.present?) || []) 
  end
  
  def point_totals_by_assignment_type_for_student(student)
    assignment_type_point_totals = {}
    self.grades_for_student(student).group_by { |g| g.assignment.assignment_type_id }.each { |assignment_type_id,grades| assignment_type_point_totals[assignment_type_id] = grades.map(&:point_total).sum }
    assignment_type_point_totals
  end
  
  def scores_by_assignment_type_for_student(student)
    assignment_type_scores = {}
    self.grades_for_student(student).group_by { |g| g.assignment.assignment_type_id }.each { |assignment_type_id,grades| assignment_type_scores[assignment_type_id] = grades.map { |g| g.score(student) }.sum }
    assignment_type_scores
  end

  def assignment_type_score_for_student(assignment_type,student)
    scores_by_assignment_type_for_student(student)[assignment_type.id]
  end
  
  def multiplier_count(student)
    student.user_assignment_type_weights.map(&:value).compact.sum 
  end
  
  def multipliers_spent?(student)
    multiplier_count(student) >= 6
  end
  
  def grades_for_course(course)
    scores = []
    students.each do |student|
      scores += grades_for_student(student)
    end
    scores    
  end
    
  def minimum_course_score
    #.min
  end
  
  def maximum_course_score
    #.max 
  end 
  
  def average_course_score
  
  end
  
  def median_course_score
    #len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2
  end
  
  

end
