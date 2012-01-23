class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_scores
end
