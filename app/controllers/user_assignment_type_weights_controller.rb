class UserAssignmentTypeWeightsController < ApplicationController
  def index
    @title = "User set assignment weights"
    @user_assignment_type_weights = UserAssignmentTypeWeight.all
    respond_with(@user_assignment_type_weights)
  end

  def show
    @title = "View assignment weight choice"
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    respond_with(@user_assignment_type_weight)
  end

  def new
    @title = "Assignment Weight"
    @users = current_course.users.students
    #TODO Filter these down to just the assignments where students set percentages
    @assignments = current_course.assignments.all
    @user_assignment_type_weight = UserAssignmentTypeWeight.new
    respond_with(@user_assignment_type_weight)
  end

  def edit
    @title = "Edit assignment weight choice"
    @users = current_course.assignments.all
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
