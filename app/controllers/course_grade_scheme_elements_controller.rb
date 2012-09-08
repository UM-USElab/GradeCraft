class CourseGradeSchemeElementsController < ApplicationController

  before_filter :ensure_staff?
  
  def index 
    @course_grade_scheme = CourseGradeScheme.find(params[:course_grade_scheme_id])
    @title = "#{@course_grade_scheme.name} Grading"
    @course_grade_scheme_elements = @course_grade_scheme.course_grade_scheme_elements.all
    respond_to do |format|
      format.html 
      format.json { render json: @course_grade_scheme_elements.as_json(only: [:id,:letter_grade, :name, :low_range, :high_range]) }
    end
  end

  def show
    @course_grade_scheme = CourseGradeScheme.find(params[:course_grade_scheme_id])
    @title = "#{@course_grade_scheme.name} Grading"
    @course_grade_scheme_element = CourseGradeSchemeElement.find(params[:id])
    respond_with(@course_grade_scheme_element)
  end

  def new
    @course_grade_scheme = CourseGradeScheme.find(params[:course_grade_scheme_id])
    @title = "Create a New #{@course_grade_scheme.name} Grading Element"
    @course_grade_scheme_element = @course_grade_scheme.course_grade_scheme_elements.create(params[:course_grade_scheme_element])
    respond_with(@course_grade_scheme)
  end

  def edit
    @course_grade_scheme = CourseGradeScheme.find(params[:course_grade_scheme_id])
    @title = "Edit #{@course_grade_scheme.name} Grading Element"
    @course_grade_scheme_element = @course_grade_scheme.course_grade_scheme_elements.find(params[:id])
    respond_with(@course_grade_scheme)
  end

  def create
    @course_grade_scheme_element = CourseGradeSchemeElement.new(params[:course_grade_scheme_element])
    @course_grade_scheme_element.save
    respond_with @course_grade_scheme_element
  end

  def update
    @course_grade_scheme = CourseGradeScheme.find(params[:course_grade_scheme_id])
    @course_grade_scheme_element = @course_grade_scheme.course_grade_scheme_elements.find(params[:id])
    @course_grade_scheme_element.update_attributes(params[:course_grade_scheme_element])
    respond_with @course_grade_scheme
  end

  def destroy
    @course_grade_scheme = CourseGradeScheme.find(params[:course_grade_scheme_id])
    @course_grade_scheme_element = @course_grade_scheme.course_grade_scheme_elements.find(params[:id])
    @course_grade_scheme_element.destroy
    
    respond_to do |format|
      format.html { redirect_to course_grade_scheme_path(@course_grade_scheme), notice: 'Grade Scheme Element was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
