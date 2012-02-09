class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_grades, :dependent => :destroy

  def user_grades
    Grade.where(:user_id => users)
  end

  def ranking

  end

  def score
    challenge_grade + reading_reaction_score
  end

  def challenge_grade
    challenge_grades.sum(:score)
  end

  def reading_reaction_score
    500 * user_grades.reading_reaction.where(:semis => true).count
  end

end
