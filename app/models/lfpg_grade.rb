class LFPGGrade < Grade
  
  def points_possible
    if attempted?
      assignment.point_total
    else
     0
    end
  end

end