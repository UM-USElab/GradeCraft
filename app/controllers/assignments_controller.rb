class AssignmentsController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?, :except => [:index]

  def index
    @title = "View All Assignments"
    @assignments = current_course.assignments
    @assignment_types = current_course.assignment_types
    respond_with @assignments
  end

  def show
    respond_with @assignment = current_course.assignments.find(params[:id])
  end

  def new
    @title = "Create a New Assignment"
    @assignment = current_course.assignments.new
    @assignment_types = current_course.assignment_types.all
    @grade_schemes = current_course.grade_schemes
  end

  def edit
    @title = "Edit this Assignment"
    @assignment = current_course.assignments.all
    @assignment_types = current_course.assignment_types.all
    @grade_schemes = current_course.grade_schemes
    respond_with @assignment = current_course.assignments.find(params[:id])
  end

  def create
    @assignment = current_course.assignments.new(params[:assignment])
    if @assignment.save
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully created.'
    else
      respond_with @assignment
    end
  end

  def update
    @assignment = current_course.assignments.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully updated.'
    else
      respond_with @assignment
    end
  end

  def destroy
    @assignment = current_course.assignments.find(params[:id])
    @assignment.destroy
    respond_with(@assignment)
  end
end
