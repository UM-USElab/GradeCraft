class GradeSchemeElementsController < ApplicationController

  before_filter :ensure_staff?
  
  def index 
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    @title = "#{@grade_scheme.name} Grading"
    @grade_scheme_elements = @grade_scheme.grade_scheme_elements.all
    respond_with(@grade_scheme_elements)
  end

  def show
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    @title = "#{@grade_scheme.name} Grading"
    @grade_scheme_element = GradeSchemeElement.find(params[:id])
    respond_with(@grade_scheme_element)
  end

  def new
    @grade_schemes = current_course.grade_schemes.all
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    @title = "Create a New #{@grade_scheme.name} Grading Element"
    @grade_scheme_element = @grade_scheme.grade_scheme_elements.create(params[:grade_scheme_element])

  end

  def edit
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    @title = "Edit #{@grade_scheme.name} Grading Element"
    @grade_scheme_element = @grade_scheme.grade_scheme_elements.find(params[:id])
    respond_with(@grade_scheme)
  end

  def create
    @grade_scheme_element = GradeSchemeElement.new(params[:grade_scheme_element])
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    respond_to do |format|
      if @grade_scheme_element.save
        format.html { redirect_to @grade_scheme, notice: 'Grade Scheme Element was successfully created.' }
        format.json { render json: @grade_scheme_element, status: :created, location: @grade_scheme_element }
      else
        format.html { render action: "new" }
        format.json { render json: @grade_scheme_element.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    @grade_scheme_element = @grade_scheme.grade_scheme_elements.find(params[:id])
    @grade_scheme_element.update_attributes(params[:grade_scheme_element])
    respond_with @grade_scheme
  end

  def destroy
    @grade_scheme = GradeScheme.find(params[:grade_scheme_id])
    @grade_scheme_element = @grade_scheme.grade_scheme_elements.find(params[:id])
    @grade_scheme_element.destroy
    
    respond_to do |format|
      format.html { redirect_to grade_scheme_path(@grade_scheme), notice: 'Grade Scheme Element was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
