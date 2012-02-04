class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_scores
  
  before_save :calculate_score
  
  def ranking
    
  end

  #Overriding the save function so as to update the score every time a grade gets saved
  def calculate_score
    self.score = (challenge_scores.map(&:score).inject(&:+))
  end
  
  
end
