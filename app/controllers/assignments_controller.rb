class AssignmentsController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?, :except => [:index]

  def index
    @title = "View All Assignments"
    @assignments = Assignment.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  def show
    respond_with @assignment = Assignment.find(params[:id])
  end

  def new
    @title = "Create a New Assignment"
    @assignment = Assignment.new
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
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :ok }
    end
  end
end
