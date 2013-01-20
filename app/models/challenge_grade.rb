class ChallengeGrade < ActiveRecord::Base
  attr_accessible :challenge_id, :feedback, :final_score, :score, :status, :team_id
end
