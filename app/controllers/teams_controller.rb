class TeamsController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?, :only => [:new, :edit, :create, :destroy]

  def index
    @teams = current_course.teams.all
    @title = "#{current_course.team_term}s"
    respond_with @teams
  end

  def show
    @team = current_course.teams.find(params[:id])
    @title = @team.name
    @users = @team.users
    respond_with @team
  end

  def activity
    @team = current_course.teams.find(params[:id])
    @title = @team.name
    @users = @team.users
    respond_wth @team
  end

  def new
    @team =  Team.new
    @title = "Create a New #{current_course.team_term}"
    @courses = Course.all
    @users = current_course.users
    @students = @users.students
    @submit_message = "Create #{current_course.team_term}"
    respond_with @team
  end

  def create
    @team =  Team.new(params[:team])
    @team.save
    respond_with @team
  end

  def edit
    @team =  current_course.teams.find(params[:id])
    @title = "Editing #{@team.name}"
    @users = current_course.users
    @students = @users.students
    @submit_message = "Update #{current_course.team_term}"
  end

  def update
    @team =  current_course.teams.find(params[:id])
    @team.update_attributes(params[:team])
    respond_with @team
  end

  def destroy
    @team =  current_course.teams.find(params[:id])
    @team.destroy
    respond_with @team
  end

  private

  def interpolation_options
    { :resource_name => current_course.team_term }
  end

  def sort_column
     current_course.team.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
