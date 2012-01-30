class ReadingReactionGrade < Grade

  def score
    if finals?
      10000
    elsif semifinals?
      8000
    elsif complete?
      5000
    else
      0
    end
  end

end
