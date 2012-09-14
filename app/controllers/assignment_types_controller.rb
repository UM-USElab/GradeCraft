class AssignmentTypesController < ApplicationController
  
  before_filter :ensure_staff?

  def index
    @assignment_types = current_course.assignment_types
    respond_to do |format|
      format.html
      format.json { render json: @assignment_types.as_json(only:[:id, :name, :point_setting, :levels, :points_predictor_display, :resubmission, :max_value, :percentage_course, :predictor_description, :universal_point_value, :minimum_score, :step_value, :due_date_present]) }
    end
  end

  def show
    @assignment_type = current_course.assignment_types.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @assignment_types }
    end
  end
  
  def new
    @assignment_type = current_course.assignment_types.new
    @courses = Course.all
    respond_with(@assignment_type)
  end

  def edit
    @assignment_type = current_course.assignment_types.find(params[:id])
  end

  def create
    @assignment_type = current_course.assignment_types.new(params[:assignment_type])
    @assignment_type.save
    respond_with(@assignment_type)
  end

  def update
    @assignment_type = current_course.assignment_types.find(params[:id])
    @assignment_type.update_attributes(params[:assignment_type])
    respond_with(@assignment_type)
  end

  def destroy
    @assignment_type = current_course.assignment_types.find(params[:id])
    @assignment_type.destroy
    respond_with(@assignment_type)
  end
end
