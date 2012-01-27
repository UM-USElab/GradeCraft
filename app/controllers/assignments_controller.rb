class AssignmentsController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?, :except => [:index]

  def index
    @title = "View all Assignments"
    respond_with @assignments = Assignment.all
  end

  def show
    @title = "View all Assignments"
    respond_with @assignment = Assignment.find(params[:id])
  end

  def new
    @title = "Create a New Assignment"
    klass = %w{Attendance Blogging ReadingRection}.include?(params[:type]) || Assignment
    respond_with @assignment = klass.new
  end

  def edit
    @title = "Edit this Assignment"
    respond_with @assignment = Assignment.find(params[:id])
  end

  def create
    @assignment = Assignment.new(params[:assignment])
    if @assignment.save
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully created.'
    else
      respond_with @assignment
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully updated.'
    else
      respond_with @assignment
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    respond_with @assignment.destroy
  end
end
