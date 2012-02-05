class AttendanceGrade < Grade

  def points_possible
    if assignment.due_date > Date.today
      5000
    else
      0
    end
  end

end