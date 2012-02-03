class ReadingReactionChallengeScore < ChallengeScore

  def score
    500 * team.users.grades.reading_reactions.map { |g| 1 if g.semifinals? }.inject(&:+)
  end

end