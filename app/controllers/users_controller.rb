class UsersController < ApplicationController
  respond_to :html, :json

  skip_before_filter :require_login, :only=>[:create,:new]
  before_filter :'ensure_staff?', :only=>[:index,:destroy]
  before_filter :'ensure_admin?', :only=>[:all_users]

  def index
    @title = "View all #{current_course.user_term}s"
    @courses = Course.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def all_users
    @users = User.all 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def students
    @students = current_course.users.all
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @courses = Course.all
    respond_with @user
  end
  
  def predictor
    @title = "Predict Course Grade"
    respond_with @user = User.find(params[:id])
  end

  def new
    @title = "Register"
    @teams = Team.all
    @courses = Course.all
    @user.course = current_course
    respond_with @user = User.new
  end

  def edit
    @title = "Edit #{current_course.user_term}"
    @teams = Team.all
    @courses = Course.all
    respond_with @user = User.find(params[:id])
  end
  
  def create
    @teams = Team.all
    @user = User.create(params[:user])
    @courses = Course.all
    
    @user.course ||= current_course
    
    respond_with @user
  end
  
  def update
    @user = User.find(params[:id])
    @teams = Team.all
    @courses = Course.all

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
    @user = User.find(params[:id])
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

  def predictor
    if current_user.is_staff?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
  end
  
  private

end
