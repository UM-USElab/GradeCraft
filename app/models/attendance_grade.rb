class AttendanceGrade < Grade

  def points_possible
    if assignment.due_date < Date.today
      assignments.point_total
    else
      0
    end
  end

end