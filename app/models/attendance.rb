class Attendance < Assignment

  after_initialize :set_default_due_date

  def set_default_due_date
    self.due_date ||= Date.today
  end


end
