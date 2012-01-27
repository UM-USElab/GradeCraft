class Attendance < Assignment

  after_initialize :set_default_due_date

  def point_total
    5000
  end

  def set_default_due_date
    self.due_date ||= Date.today
  end


end
