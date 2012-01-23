class ChallengeScore < ActiveRecord::Base
  belongs_to :team
  belongs_to :challenge
end
