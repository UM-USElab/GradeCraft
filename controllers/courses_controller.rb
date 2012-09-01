class CoursesController < ApplicationController
  
  def index
    @title = "GradeCraft Courses"
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  def show
    @course = Course.find(params[:id])
    @users = current_course.users
    @assignments = current_course.assignments
    @grades = current_course.grades
    @teams = current_course.teams

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

  def new
    @title = "Add a New Course"
    @course = Course.new
    @themes = Theme.all
    @badge_sets = BadgeSet.all
    @course_grade_schemes = CourseGradeScheme.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  def edit
    @course = Course.find(params[:id])
    @title = "Edit Course" 
    @badge_sets = BadgeSet.all
    @themes = Theme.all
    @course_grade_schemes = CourseGradeScheme.all
    
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
