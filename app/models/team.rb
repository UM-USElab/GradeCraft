class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_scores
  
  def score
    challenge_score = assignments.grades.map(&:score).inject(&:+)
    reading_reaction_score = 500 * users.grades.reading_reactions.map { |g| 1 if g.semifinalist? }.inject(&:+)
    challenge_score + reading_reaction_score
  end

end
