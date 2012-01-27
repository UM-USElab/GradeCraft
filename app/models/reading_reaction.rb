class ReadingReaction < Assignment

  def is_complete?
    score == "5000"
  end

  def is_semifinalist?
    score == "3000"
  end

  def is_finalist?
    score == "2000"
  end

end
