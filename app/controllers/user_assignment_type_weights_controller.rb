class UserAssignmentTypeWeightsController < ApplicationController
  def index
    @user_assignment_type_weights = UserAssignmentTypeWeight.all
    respond_with(@user_assignment_type_weights)
  end

  def show
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    respond_with(@user_assignment_type_weight)
  end

  def new
    @user_assignment_type_weight = UserAssignmentTypeWeight.new
    respond_with(@user_assignment_type_weight)
  end

  def edit
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
  end

  def create
    @user_assignment_type_weight = UserAssignmentTypeWeight.new(params[:user_assignment_type_weight])
    @user_assignment_type_weight.save
    respond_with(@user_assignment_type_weight)
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
