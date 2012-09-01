class GradeSchemesController < ApplicationController

  def index
    @title = "Grading Schemes"
    @grade_schemes = current_course.grade_schemes.all

    respond_to do |format|
      format.html 
      format.json { render json: @grade_schemes }
    end
  end

  def show
    @title = "View Grading Scheme"
    @grade_scheme = current_course.grade_schemes.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @grade_scheme }
    end
  end

  def new
    @title = "Create a New Grading Scheme"
    @grade_scheme = current_course.grade_schemes.new
    @assignments = Assignment.all
    respond_to do |format|
      format.html 
      format.json { render json: @grade_scheme }
    end
  end

  def edit
    @title = "Update Grading Scheme"
    @grade_scheme = current_course.grade_schemes.find(params[:id])
    @assignments = Assignment.all
  end

  def create
    @grade_scheme = current_course.grade_schemes.new(params[:grade_scheme])
    @assignments = Assignment.all

    respond_to do |format|
      if @grade_scheme.save
        format.html { redirect_to @grade_scheme, notice: 'Grade scheme was successfully created.' }
        format.json { render json: @grade_scheme, status: :created, location: @grade_scheme }
      else
        format.html { render action: "new" }
        format.json { render json: @grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def destroy_multiple
    @grade_schemes = current_course.grade_schemes.find(params[:grade_scheme_ids])
    @grade_schemes.delete
    
    respond_to do |format|
      format.html { redirect_to grade_schemes_url }
      format.json { head :ok }
    end
  end

  def update
    @grade_scheme = current_course.grade_schemes.find(params[:id])
    @assignments = Assignment.all
    respond_to do |format|
      if @grade_scheme.update_attributes(params[:grade_scheme])
        format.html { redirect_to @grade_scheme, notice: 'Grade scheme was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @grade_scheme = current_course.grade_schemes.find(params[:id])
    @grade_scheme.destroy

    respond_to do |format|
      format.html { redirect_to grade_schemes_url }
      format.json { head :ok }
    end
  end

end
