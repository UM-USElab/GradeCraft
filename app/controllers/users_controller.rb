class UsersController < ApplicationController
  respond_to :html, :json

  skip_before_filter :require_login, :only=>[:create,:new]
  before_filter :'ensure_staff?', :only=>[:index,:destroy]
  before_filter :'ensure_admin?', :only=>[:all_users]

  def index
    @title = "View all Users"
    @users =  current_course.users.order(:last_name)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.csv { send_data @users.to_csv }
      format.xls { send_data @users.to_csv(col_sep: "\t") }
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
    @users = current_course.users
    @students = current_course.users.students.order(:last_name)
    @teams = current_course.teams.all 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.csv { send_data @users.to_csv }
      format.xls { send_data @users.to_csv(col_sep: "\t") }
    end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @earned_badges = @user.earned_badges
    @assignment_types = current_course.assignment_types
    @assignments = current_course.assignments
    @grades = @user.grades.all 
    #@grade = @user.grades.find(params[:assignment_id => assignment_id])
    #@grades_by_assignment_type = @grades.group_by(&:assignment_type)
    @grades_by_assignment_type = @user.grades(:include => :assignment).group_by(&:assignment_type)
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
    @courses = Course.all
    @user = current_course.users.new(params[:users])
    respond_with @user
  end

  def edit
    @title = "Edit #{current_course.user_term}"
    @teams = current_course.teams.all
    @courses = Course.all
    @user = current_course.users.find(params[:id])
    respond_with @user
  end
  
  def create
    @teams = current_course.teams.all
    @user = current_course.users.create(params[:user])
    @user.save
    #@user.course ||= current_course
    
    respond_with @user
  end
  
  def update
    @user = User.find(params[:id])
    @teams = Team.all
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #TODO Not currently working
  def destroy
    @user = current_course.users.find(params[:id])
    
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end

  end

  def edit_profile
    @title = "Edit My Account"
    respond_with @user = current_user
  end

  def update_profile
    @user = current_user
    @user.update_attribute(:password, params[:password]) if params[:password] == params[:confirm_password]
    respond_with(@user)
  end
  
  
  private

end
