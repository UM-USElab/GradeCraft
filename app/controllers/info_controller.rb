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
  
  #coryhelp! Need to filter the users shown down to just students, but when I apply the student method then only ten total students are displayed on the dashboard
  def dashboard
    @title = "My Dashboard"
    @teams = current_course.teams.all
    @users= current_course.users
  end

end
