class Team < ActiveRecord::Base
  
  has_many :team_memberships
  has_many :users, :through => :team_memberships
  has_many :grades, :as => :gradeable, :dependent => :destroy
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  
  belongs_to :course
  
  attr_accessible :name, :created_at, :updated_at, :banner_file_name, :banner_updated_at, :sortable_score, :rank, :team_id, :user_ids, :course_id

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

end
