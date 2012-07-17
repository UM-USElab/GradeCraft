class CourseGradeSchemesController < ApplicationController
  # GET /course_grade_schemes
  # GET /course_grade_schemes.json
  def index
    @course_grade_schemes = current_course.course_grade_schemes.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_grade_schemes }
    end
  end

  # GET /course_grade_schemes/1
  # GET /course_grade_schemes/1.json
  def show
    @course_grade_scheme = CourseGradeScheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_grade_scheme }
    end
  end

  # GET /course_grade_schemes/new
  # GET /course_grade_schemes/new.json
  def new
    @course_grade_scheme = CourseGradeScheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_grade_scheme }
    end
  end

  # GET /course_grade_schemes/1/edit
  def edit
    @course_grade_scheme = CourseGradeScheme.find(params[:id])
  end

  # POST /course_grade_schemes
  # POST /course_grade_schemes.json
  def create
    @course_grade_scheme = CourseGradeScheme.new(params[:course_grade_scheme])

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

  # PUT /course_grade_schemes/1
  # PUT /course_grade_schemes/1.json
  def update
    @course_grade_scheme = CourseGradeScheme.find(params[:id])

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

  # DELETE /course_grade_schemes/1
  # DELETE /course_grade_schemes/1.json
  def destroy
    @course_grade_scheme = CourseGradeScheme.find(params[:id])
    @course_grade_scheme.destroy

    respond_to do |format|
      format.html { redirect_to course_grade_schemes_url }
      format.json { head :no_content }
    end
  end
end
