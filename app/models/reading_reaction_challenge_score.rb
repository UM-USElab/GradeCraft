class ReadingReactionChallengeScore < ChallengeScore

  def reading_reaction_score
    500 * team.users.grades.reading_reactions.map { |g| 1 if g.semifinals? }.inject(&:+)
  end

end