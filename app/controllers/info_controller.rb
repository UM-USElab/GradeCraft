class InfoController < ApplicationController
  respond_to :html
  
  skip_before_filter :require_login, :except => [:dashboard]

  helper_method :sort_column, :sort_direction

  
  def dashboard
    @title = "My Dashboard"
    @teams = current_course.teams.all
    @students = current_course.users.students
    @top_ten_students = @students.order('sortable_score DESC').limit(10)
    @bottom_ten_students = @students.order('sortable_score ASC').limit(10)
    @assignments = current_course.assignments
  end

end
