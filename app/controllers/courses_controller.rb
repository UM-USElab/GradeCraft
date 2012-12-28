class CoursesController < ApplicationController

  before_filter :ensure_staff?

  def index
    @title = "Course Index"
    @courses = Course.all

    respond_to do |format|
      format.html 
      format.json { render json: @courses }
    end
  end

  def show
    @title = "Course Settings"
    @course = Course.find(params[:id])
    @themes = Theme.all
    @users = current_course.users.all
    respond_to do |format|
      format.html
      format.json { render json: @course }
    end
  end

  def new
    @course = Course.new
    @themes = Theme.all
    @badge_sets = BadgeSet.all
    @grade_schemes = GradeScheme.all

    respond_to do |format|
      format.html
      format.json { render json: @course }
    end
  end

  def edit
    @title = "Edit Basic Settings"
    @course = Course.find(params[:id])
    @course_grade_schemes = CourseGradeScheme.all
    @badge_sets = BadgeSet.all
    @themes = Theme.all
    @grade_schemes = GradeScheme.all
    
  end

  def create
    @course = Course.new(params[:course])
    @badge_sets = BadgeSet.all

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end
end
