class CourseGradeSchemesController < ApplicationController

  def index
    @title = "Grade Scheme Elements"
    @course_grade_schemes = current_course.course_grade_schemes

    respond_to do |format|
      format.html
      format.json { render json: @course_grade_schemes }
    end
  end

  def show
    @course_grade_scheme = current_course.course_grade_schemes.find(params[:id])
    @title = "View #{@course_grade_scheme.name} Grade Range"
    respond_to do |format|
      format.html
      format.json { render json: @course_grade_scheme }
    end
  end

  def new
    @title = "Create a New Grading Element"
    @course_grade_scheme = current_course.course_grade_schemes.new

    respond_to do |format|
      format.html
      format.json { render json: @course_grade_scheme }
    end
  end


  def edit
    @course_grade_scheme = current_course.course_grade_schemes.find(params[:id])
    @title = "Edit #{@course_grade_scheme.name} Grade Range"
    
  end

  def create
    @course_grade_scheme = current_course.course_grade_schemes.new(params[:course_grade_scheme])

    respond_to do |format|
      if @course_grade_scheme.save
        format.html { redirect_to @course_grade_scheme, notice: 'Course grade scheme was successfully created.' }
        format.json { render json: @course_grade_scheme, status: :created, location: @course_grade_scheme }
      else
        format.html { render action: "new" }
        format.json { render json: @course_grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @course_grade_scheme = current_course.course_grade_schemes.find(params[:id])

    respond_to do |format|
      if @course_grade_scheme.update_attributes(params[:course_grade_scheme])
        format.html { redirect_to @course_grade_scheme, notice: 'Course grade scheme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course_grade_scheme = current_course.course_grade_schemes.find(params[:id])
    @course_grade_scheme.destroy

    respond_to do |format|
      format.html { redirect_to course_grade_schemes_url }
      format.json { head :no_content }
    end
  end
end
