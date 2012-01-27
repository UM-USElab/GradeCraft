class ReadingReaction < Assignment

  Levels = ['Semifinalist','Finalist','Complete']

  def complete?
    level == 'Complete'
  end

  def semifinalist?
    level == 'Semifinalist'
  end

  def finalist?
    level == 'Finalist'
  end

  def point_total
    if complete?
      5000
    elsif semifinalist?
      3000
    elsif finalist?
      2000
    else
      0
    end
  end

end
