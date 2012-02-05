class ReadingReactionGrade < Grade

  def score
    if finals?
      10000
    elsif semis?
      8000
    elsif complete?
      5000
    else
      0
    end
  end
  
  def points_possible
    if assignment.due_date < Date.today
      5000
    else
      0
    end
  end

end
