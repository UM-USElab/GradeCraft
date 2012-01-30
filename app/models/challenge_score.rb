class ChallengeScore < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge
  
  validates :team_id, :presence => true
  validates :score, :presence => true
  validates :challenge_id, :presence => true
  
  after_save :save_team_score
  
  def save_team_score
    team.save
  end
  
end
