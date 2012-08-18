class GradeSchemeElementsController < ApplicationController
  # GET /grade_scheme_elements
  # GET /grade_scheme_elements.xml
  def index
    @grade_scheme_elements = current_course.gradeschemeelements.all
    respond_with(@grade_scheme_elements)
  end

  # GET /grade_scheme_elements/1
  # GET /grade_scheme_elements/1.xml
  def show
    @grade_scheme_element = GradeSchemeElement.find(params[:id])
    respond_with(@grade_scheme_element)
  end

  # GET /grade_scheme_elements/new
  # GET /grade_scheme_elements/new.xml
  def new
    @grade_scheme_element = GradeSchemeElement.new
    @grade_schemes = current_course.grade_schemes
    respond_with(@grade_scheme_element)
  end

  # GET /grade_scheme_elements/1/edit
  def edit
    @grade_scheme_element = GradeSchemeElement.find(params[:id])
  end

  # POST /grade_scheme_elements
  # POST /grade_scheme_elements.xml
  def create
    @grade_scheme_element = GradeSchemeElement.new(params[:grade_scheme_element])
    @grade_scheme_element.save
    respond_with(@grade_scheme_element)
  end

  # PUT /grade_scheme_elements/1
  # PUT /grade_scheme_elements/1.xml
  def update
    @grade_scheme_element = GradeSchemeElement.find(params[:id])
    @grade_scheme_element.update_attributes(params[:grade_scheme_element])
    respond_with(@grade_scheme_element)
  end

  # DELETE /grade_scheme_elements/1
  # DELETE /grade_scheme_elements/1.xml
  def destroy
    @grade_scheme_element = GradeSchemeElement.find(params[:id])
    @grade_scheme_element.destroy
    respond_with(@grade_scheme_element)
  end
end
