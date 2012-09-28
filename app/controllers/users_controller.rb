class UsersController < ApplicationController
  respond_to :html, :json

  skip_before_filter :require_login, :only=>[:create,:new]
  before_filter :'ensure_staff?', :only=>[:index,:destroy,:show, :edit, :new]
  before_filter :'ensure_admin?', :only=>[:all_users]
  
  def import
    if request.post? && params[:file].present?
      infile = params[:file].read
      n, errs = 0, []

      CSV.parse(infile) do |row|
        n += 1
        # SKIP: header i.e. first row OR blank row
        next if n == 1 or row.join.blank?
        # build_from_csv method will map customer attributes & 
        # build new customer record
        user = User.build_from_csv(row)
        # Save upon valid 
        # otherwise collect error records to export
        if user.valid?
          user.save
        else
          errs << row
        end
      end
      # Export Error file for later upload upon correction
      if errs.any?
        errFile ="errors_#{Date.today.strftime('%d%b%y')}.csv"
        errs.insert(0, User.csv_header)
        errCSV = CSV.generate do |csv|
          errs.each {|row| csv << row}
        end
        send_data errCSV,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=#{errFile}.csv"
      else
        flash[:notice] = I18n.t('user.import.success')
        redirect_to import_url #GET
      end
    end
  end

  def index
    @title = "View all Users"
    @users =  current_course.users.order(:last_name)
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @users = current_course.users.includes(:teams).where(user_search_options)
    respond_to do |format|
      format.html
      format.json { render json: @users }
      format.csv { send_data @users.to_csv }
      format.xls { send_data @users.to_csv(col_sep: "\t") }
    end
  end
  
  def all
    @users = User.all 
    respond_to do |format|
      format.html
      format.json { render json: @all_users }
    end
  end
  
  def students
    @users = current_course.users
    @students = current_course.users.students
    @teams = current_course.teams.all
    @sorted_students = @students.order('users.sortable_score DESC')
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @sorted_students = current_course.users.students.includes(:teams).where(user_search_options).order('users.sortable_score DESC')
    respond_to do |format|
      format.html
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
    @badges = current_course.badges
    respond_with @user
  end
  
  def predictor
    increment_predictor_views
    @assignment_types = current_course.assignment_types.all
    @assignments = current_course.assignments.all
    @badges = current_course.badges.all
    if current_user.is_staff?
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    if params[:in_progress]
      @assignment_type_scores = @assignment_types.map { |assignment_type| { :data => [current_course.current_scores_by_assignment_type_for_student(@user)[assignment_type.id]], :name => assignment_type.name } }
    else
      @assignment_type_scores = @assignment_types.map { |assignment_type| { :data => [current_course.scores_by_assignment_type_for_student(@user)[assignment_type.id]], :name => assignment_type.name } }
    end
    @assignment_type_scores += [{ :data => [@user.earned_badges_value(current_course)], :name => 'Badges' }]
    respond_with @user do |format|
      format.json { render :json => {
        :student_name => @user.name,
        :scores => @assignment_type_scores,
        :course_total => @user.total_points_for_course(current_course,params[:in_progress])
      }.to_json }
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
    @title = "Edit #{current_course.user_ref}"
    @teams = current_course.teams.all
    @courses = Course.all
    @user = current_course.users.find(params[:id])
    respond_with @user
  end
  
  def create
    @teams = current_course.teams.all
    @user = current_course.users.create(params[:user])
    @user.save
    
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
    
  
  def import
  
  end
  
  def upload 
    require 'csv'    
    
    if params[:file].blank?
      flash[:notice] = "File missing"
      redirect_to users_path
    else
      CSV.foreach(params[:file].tempfile, :headers => false) do |row|
        User.create! do |u|
          u.first_name = row[0]
          u.last_name = row[1] 
          u.username = row[2] 
          u.email = row[3]
          u.role = 'student'
        end
      end
      redirect_to users_path, :notice => "Upload successful"
    end
  end
  
  def choices
    @students = current_course.users.students
    @assignment_types = current_course.assignment_types
    @teams = current_course.teams.all
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @students = current_course.users.students.includes(:teams).where(user_search_options).order('users.sortable_score DESC')
  end

  
  private
  
  
  def increment_predictor_views
    User.increment_counter(:predictor_views, current_user.id) if current_user && request.format.html?
  end

end
