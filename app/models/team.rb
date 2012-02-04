class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_scores

  def user_grades
    Grade.where(:user_id => users)
  end

  def ranking

  end

  def score
    challenge_score + reading_reaction_score
  end

  def challenge_score
    challenge_scores.sum(:score)
  end

  def reading_reaction_score
    500 * user_grades.reading_reactions.where(:semis => true).count
  end

end
