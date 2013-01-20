class RubricsController < ApplicationController
  def index
    @rubrics = Rubric.all
    respond_with(@rubrics)
  end

  def show
    @rubric = Rubric.find(params[:id])
    respond_with(@rubric)
  end

  def new
    @rubric = Rubric.new
    @assignment = Assignment.find(params[:assignment_id])
    
    @title = "Create a Rubric for #{@assignment.name} "
    respond_with assignment_rubric_path(@assignment, @rubric)
  end

  def edit
    @rubric = Rubric.find(params[:id])
  end

  def create
    @rubric = Rubric.new(params[:rubric])
    @rubric.save
    respond_with(@rubric)
  end

  def update
    @rubric = Rubric.find(params[:id])
    @rubric.update_attributes(params[:rubric])
    respond_with(@rubric)
  end

  def destroy
    @rubric = Rubric.find(params[:id])
    @rubric.destroy
    respond_with(@rubric)
  end
end
