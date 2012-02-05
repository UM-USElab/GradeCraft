class StandardGrade < Grade
  
  def points_possible
    if assignment.attempted == "1"
      assignments.point_total
    else
      0
    end
  end

end