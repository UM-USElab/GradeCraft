class InfoController < ApplicationController
  respond_to :html

  helper_method :sort_column, :sort_direction
  
  def index
    @title = "Site Credits"
    @users = current_course.users.students
    @teams = current_course.teams.all
  end

  def show
    @title = "Site Credits"
    @users = User.all
    @teams = Team.all
  end
  
  def dashboard
    @title = "My Dashboard"
    @teams = current_course.teams.all
    @students = current_course.users.unscoped.students
    @top_ten_students = @students.order('sortable_score DESC').limit(10)
    @bottom_ten_students = @students.order('sortable_score ASC').limit(10)
  end

end
