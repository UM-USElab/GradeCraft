class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_scores

  before_save :calculate_score

  def user_grades
    Grade.where(:user_id => users)
  end

  def ranking

  end

  def rr_score
    self.score = 500 * user_grades.reading_reactions.where(:semis => 1).count
  end

  #Overriding the save function so as to update the score every time a grade gets saved
  def calculate_score
    self.score = (challenge_scores.map(&:score).inject(&:+)) + rr_score
  end


end
