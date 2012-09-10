class TeamsController < ApplicationController

  before_filter :ensure_staff?, :only=>[:new,:edit,:create,:destroy]

  def index
    @title = "#{current_course.team_ref}s"
    @teams = current_course.teams.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  def show
    @team = current_course.teams.find(params[:id])
    @title = "View #{@team.name}s"
    @users = @team.users

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  def new
    @title = "Create a New #{current_course.team_ref}"
    @team =  Team.new
    @courses = Course.all
    @users = current_course.users

    respond_with @team
  end

  def edit
    @team =  current_course.teams.find(params[:id])
    @title = "Edit #{@team.name}s"
    @users = current_course.users
    @students = @users.students
  end

  def create
    @course = Course.new(params[:course])
    @team =  Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "#{current_course.team_ref} was successfully created." }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @team =  current_course.teams.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team =  current_course.team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :ok }
    end
  end
  
  def sort_column
     current_course.team.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
