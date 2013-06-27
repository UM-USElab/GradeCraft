class UserAssignmentTypeWeightsController < ApplicationController
  
  before_filter :'ensure_staff?', :only=>[:index]

  def index
    @title = "View all #{current_course.multiplier_term}"
    @user = User.find(params[:user_id])
    @user_assignment_type_weights = @user.user_assignment_type_weights.all
    @assignment_types = current_course.assignment_types
    respond_with(@user_assignment_type_weights)
  end

  def show
    @title = "User Set Kapital"
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = @user.user_assignment_type_weights.find(params[:id])
    if current_user.is_student?
      enforce_view_permission(@user_assignment_type_weight)
    end
  end

  def new
    @user = User.find(params[:user_id])
    @assignment_type = AssignmentType.find(params[:assignment_type_id])
    @assignment_types = current_course.assignment_types.where(:student_weightable => "true")
    @user_assignment_type_weight = @user.user_assignment_type_weights.new
    respond_with(user_user_assignment_type_weights_path)
  end

  def edit
    @user = User.find(params[:user_id])
    @assignment_type = AssignmentType.find(params[:assignment_type_id])
    @assignment_types = current_course.assignment_types.where(:student_weightable => "true")
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = @user.user_assignment_type_weights.build(params[:user_assignment_type_weight])
    respond_to do |format|
      if @user_assignment_type_weight.save
        format.html { redirect_to user_user_assignment_type_weights_path(@user), notice: 'Choice was successfully created.' }
        format.json { render json: dashboard_path, status: :created, location: @user_assignment_type_weight }
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
    redirect_to dashboard_path
  end

  def destroy
    @user = User.find(params[:user_id])
    @user_assignment_type_weight = UserAssignmentTypeWeight.find(params[:id])
    @user_assignment_type_weight.destroy
    redirect_to user_user_assignment_type_weights_path(@user)
  end
end
