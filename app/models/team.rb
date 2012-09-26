class Team < ActiveRecord::Base
  
  has_many :team_memberships
  has_many :users, :through => :team_memberships
  has_many :grades, :as => :gradeable, :dependent => :destroy
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  
  before_save :set_sortable_score
  
  belongs_to :course
  attr_accessible :name, :created_at, :updated_at, :banner_file_name, :banner_updated_at, :sortable_score, :rank, :team_id, :user_ids, :course_id
  
  validates_presence_of :name, :course_id
  
  has_many :assignment_submissions, :as => :submittable, :dependent => :destroy

  default_scope :order => 'id ASC'

  def user_grades
    Grade.where(:user_id => users)
  end

  def score
    grades.map(&:score).inject(&:+) || 0
  end

  def badge_count
    earned_badges.count 
  end
  
  def team_leader
    users.gsis.first
  end

  private

  def set_sortable_score
    self.sortable_score = grades.reload.map(&:score).inject(&:+) || 0
  end
  
end
