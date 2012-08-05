class UsersController < ApplicationController
  respond_to :html, :json

  skip_before_filter :require_login, :only=>[:create,:new]
  before_filter :'ensure_staff?', :only=>[:index,:destroy]
  before_filter :'ensure_admin?', :only=>[:all_users]

  def index
    @title = "View all #{current_course.user_term}s"
    @users =  current_course.users
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def all_users
    @users = current_course.users.all 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def students
    @students = current_course.users.students.all
    @teams = current_course.teams.all
  end

  def show
    @user = current_course.users.find(params[:id])
    @title = @user.name
    @assignment_types = current_course.assignment_types
    @assignments = current_course.assignments
    @grades_by_assignment_type = @user.grades.all(:include => :assignment).group_by(&:assignment_type)
    respond_with @user
  end
  
  def predictor
    @title = "Predict Course Grade"
    if current_user.is_staff?
      @user = User.find(params[:user_id])
    else
      @user = current_user
      User.increment_counter(:predictor_views, current_user.id) if current_user
    end
  end

  def new
    @title = "Register"
    @teams = current_course.teams.all
    @user.course = current_course.users.new(params[:users])
    respond_with @user
  end

  def edit
    @title = "Edit #{current_course.user_term}"
    @teams = current_course.teams.all
    @user = current_course.users.find(params[:id])
    respond_with @user
  end
  
  def create
    @teams = current_course.teams.all
    @user = current_course.users.create(params[:user])
    
    @user.course ||= current_course
    
    respond_with @user
  end
  
  def update
    @user = User.find(params[:id])
    @teams = Team.all

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_course.users.find(params[:id])
    @user.destroy
    respond_with @user
  end

  def edit_profile
    @title = "Edit My Account"
    respond_with @user = current_user
  end

  def update_profile
    @user = current_user
    @user.update_attribute(:password, params[:password]) if params[:password] == params[:confirm_password]
    respond_with @user
  end
  
  
  private

end
