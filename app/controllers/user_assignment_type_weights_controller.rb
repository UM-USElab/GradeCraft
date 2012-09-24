class UserAssignmentTypeWeightsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_assignment_type_weights = @user.user_assignment_type_weights.all
    respond_with(@user_assignment_type_weights)
  end

  def show
    @title = "User Set Kapital"
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = @user.user_assignment_type_weights.find(params[:id])
    respond_with(@user_assignment_type_weight)
  end

  def new
    @user = User.find(params[:user_id])
    @assignment_types = current_course.assignment_types.where(:user_percentage_set => "true")
    @user_assignment_type_weight = @user.user_assignment_type_weights.new
    respond_with(user_user_assignment_type_weights_path)
  end

  def edit
    @user = User.find(params[:user_id])
    @assignment_types = current_course.assignment_types.where(:user_percentage_set => "true")
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = @user.user_assignment_type_weights.build(params[:user_assignment_type_weight])
    respond_to do |format|
      if @user_assignment_type_weight.save
        format.html { redirect_to user_user_assignment_type_weights_path(@user), notice: 'Choice was successfully created.' }
        format.json { render json: @user_assignment_type_weight, status: :created, location: @user_assignment_type_weight }
      else
        format.html { render action: "new" }
        format.json { render json: @user_assignment_type_weight.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    @user_assignment_type_weight.update_attributes(params[:user_assignment_type_weight])
    redirect_to user_user_assignment_type_weights_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    @user_assignment_type_weight.destroy
    redirect_to user_user_assignment_type_weights_path(@user)
  end
end
