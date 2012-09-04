class CourseGradeSchemesController < ApplicationController

  before_filter :ensure_staff?

  def index
    @title = "Course Grading Schemes"
    @course_grade_schemes = CourseGradeScheme.all

    respond_to do |format|
      format.html 
      format.json { render json: @course_grade_schemes }
    end
  end

  def show
    @title = "View Grading Scheme"
    @course_grade_scheme = CourseGradeScheme.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @course_grade_scheme }
    end
  end

  def new
    @title = "Create a New Grading Scheme"
    @course_grade_scheme = CourseGradeScheme.new
    respond_to do |format|
      format.html 
      format.json { render json: @course_grade_scheme }
    end
  end

  def edit
    @title = "Update Grading Scheme"
    @course_grade_scheme = CourseGradeScheme.find(params[:id])
  end

  def create
    @course_grade_scheme = CourseGradeScheme.new(params[:course_grade_scheme])

    respond_to do |format|
      if @course_grade_scheme.save
        format.html { redirect_to @course_grade_scheme, notice: 'Grade scheme was successfully created.' }
        format.json { render json: @course_grade_scheme, status: :created, location: @course_grade_scheme }
      else
        format.html { render action: "new" }
        format.json { render json: @course_grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def destroy_multiple
    @course_grade_schemes = CourseGradeScheme.find(params[:course_grade_scheme_ids])
    @course_grade_schemes.delete
    
    respond_to do |format|
      format.html { redirect_to course_grade_schemes_url }
      format.json { head :ok }
    end
  end

  def update
    @course_grade_scheme = CourseGradeScheme.find(params[:id])
    respond_to do |format|
      if @course_grade_scheme.update_attributes(params[:course_grade_scheme])
        format.html { redirect_to @course_grade_scheme, notice: 'Course grade scheme was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course_grade_scheme = CourseGradeScheme.find(params[:id])
    @course_grade_scheme.destroy

    respond_to do |format|
      format.html { redirect_to course_grade_schemes_url }
      format.json { head :ok }
    end
  end

end
