class Team < ActiveRecord::Base

  has_many :team_memberships
  has_many :users, :through => :team_memberships
  has_many :challenge_grades, :dependent => :destroy
  has_many :earned_badges, :as => :earnable, :dependent => :destroy

  #before_save :set_sortable_score

  belongs_to :course
  attr_accessible :name, :created_at, :updated_at, :banner_file_name, :banner_updated_at, :sortable_score, :rank, :team_id, :user_ids, :course_id, :team_memberships_attributes

  validates_presence_of :name, :course_id

  has_many :assignment_submissions, :as => :submittable, :dependent => :destroy

  #default_scope :order => 'id ASC'

  def user_grades
    Grade.where(:user_id => students)
  end

  def score
    challenge_grades.map(&:raw_score).sum || 0
  end

  def badge_count
    earned_badges.count
  end

  def grades_by_assignment_id
    @grades_by_assignment ||= grades.group_by(&:assignment_id)
  end

  def grade_for_assignment(assignment)
    grades_by_assignment_id[assignment.id].try(:first)
  end

  def students
    users
  end

  def student_count
    students.count
  end

  def student_badge_count
    students.sum(&:user_badge_count)
  end

  def team_leader
    students.gsis.first
  end

  def students_by_team_id
    @students_by_team_id ||= students.group_by(&:team_id)
  end

  def students_in_team(team)
    students_by_team_id[team.id].try(:first)
  end

  def membership_for_student(student)
    memberships_by_student_id[student.id] || team_memberships.new(:user_id => student.id)
  end

  private

  def memberships_by_student_id
    @memberships_by_student_id ||= {}.tap do |m|
      team_memberships.each do |membership|
        m[membership.user_id] = membership
      end
    end
  end

end
