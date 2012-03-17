class UsersController < ApplicationController
  respond_to :html, :json

  skip_before_filter :require_login, :only=>[:create,:new]
  before_filter :'ensure_staff?', :only=>[:index,:destroy]

  helper_method :sort_column, :sort_direction

  def index
    @title = "View all Players"
    search_options = {}
    if params[:role].present?
      @role = params[:role]
      search_options[:role] = @role
    end
    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      search_options[:team_id] = @team.id if @team
    end
    respond_with @users = User.where(search_options).order(sort_column + " " + sort_direction)
  end

  def show
    @title = "View Player"
    respond_with @user = User.find(params[:id])
  end
  
  def predictor
    @title = "Predict Course Grade"
    respond_with @user = User.find(params[:id])
  end

  def new
    @title = "Register"
    @teams = Team.all
    respond_with @user = User.new
  end

  def edit
    @title = "Edit Player"
    @teams = Team.all
    respond_with @user = User.find(params[:id])
  end

  def create
    @teams = Team.all
    @user = User.create(params[:user])
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
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end

  def edit_profile
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

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  

end
