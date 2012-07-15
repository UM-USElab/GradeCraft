class AssignmentsController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?, :except => [:index]

  def index
    @title = "View All Assignments"
    @assignments = current_course.assignments
    respond_with @assignments
  end

  def show
    respond_with @assignment = current_course.assignments.find(params[:id])
  end

  def new
    @title = "Create a New Assignment"
    @assignment = current_course.assignments.new
  end

  def edit
    @title = "Edit this Assignment"
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
    respond_with @assignment
  end
end
