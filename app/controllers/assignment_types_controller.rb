class AssignmentTypesController < ApplicationController
  # GET /assignment_types
  # GET /assignment_types.xml
  def index
    @title = "Assignment Types"
    @assignment_types = AssignmentType.all
    respond_with(@assignment_types)
  end

  # GET /assignment_types/1
  # GET /assignment_types/1.xml
  def show
    @assignment_type = AssignmentType.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @assignment_type }
    end
  end

  # GET /assignment_types/new
  # GET /assignment_types/new.xml
  def new
    @title = "Create a New Assignment Type"
    @assignment_type = AssignmentType.new
    respond_with(@assignment_type)
  end

  # GET /assignment_types/1/edit
  def edit
    @assignment_type = AssignmentType.find(params[:id])
  end

  # POST /assignment_types
  # POST /assignment_types.xml
  def create
    @assignment_type = AssignmentType.new(params[:assignment_type])
    @assignment_type.save
    respond_with(@assignment_type)
  end

  # PUT /assignment_types/1
  # PUT /assignment_types/1.xml
  def update
    @assignment_type = AssignmentType.find(params[:id])
    @assignment_type.update_attributes(params[:assignment_type])
    respond_with(@assignment_type)
  end

  # DELETE /assignment_types/1
  # DELETE /assignment_types/1.xml
  def destroy
    @assignment_type = AssignmentType.find(params[:id])
    @assignment_type.destroy
    respond_with(@assignment_type)
  end
end
