class ChallengeGrade < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge
  
  validates :team_id, :presence => true
  validates :challenge_id, :presence => true
  
  after_save :save_team_score
  
  def score
    super || 0
  end
  
  def save_team_score
    team.save
  end
  
end
