class UserAssignmentTypeWeightsController < ApplicationController
  def index
    @title = "User set assignment weights"
    @user = User.find(params[:user_id])
    @user_assignment_type_weights = @user.user_assignment_type_weights
    respond_with(@user_assignment_type_weights)
  end

  def show
    @title = "View assignment weight choice"
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    respond_with(@user_assignment_type_weight)
  end

  def new
    @title = "Assignment Weight"
    @user = User.find(params[:user_id])
    @users = current_course.users.students
    @assignment_types = current_course.assignment_types.where(:user_percentage_set => "true")
    @user_assignment_type_weight = UserAssignmentTypeWeight.new
    respond_with(user_user_assignment_type_weights_path)
  end

  def edit
    @title = "Edit assignment weight choice"
    @users = current_course.assignments.all
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
  end

  def create
    @user_assignment_type_weight = UserAssignmentTypeWeight.new(params[:user_assignment_type_weight])
    @user = User.find(params[:user_id])
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
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    @user_assignment_type_weight.update_attributes(params[:user_assignment_type_weight])
    respond_with(@user_assignment_type_weight)
  end

  def destroy
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    @user_assignment_type_weight.destroy
    respond_with(@user_assignment_type_weight)
  end
end
