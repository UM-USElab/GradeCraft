class AssignmentsController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?

  def index
    @title = "View All Assignments"
    @assignments = current_course.assignments
    @assignment_types = current_course.assignment_types
    @grade_schemes = current_course.grade_schemes.all
    respond_to do |format|
      format.html
      format.json { render json: @assignments.as_json(only:[:id, :name, :description, :point_total, :due_date, :assignment_type_id, :grade_scheme_id, :grade_scope, :visible, :required ]) }
    end
  end
  
   def settings
    @title = "View All Assignments"
    @assignments = current_course.assignments
    @assignment_types = current_course.assignment_types
    @grade_schemes = current_course.grade_schemes.all
    respond_to do |format|
      format.html
      format.json { render json: @assignments.as_json(only:[:id, :name, :description, :point_total, :due_date, :assignment_type_id, :grade_scheme_id, :grade_scope, :visible, :required ]) }
    end
  end

  def show
    @assignment = current_course.assignments.find(params[:id])
    @students = current_course.users.students.includes(:grades)
    @student = @students.where(params[:id])
    @grades = @assignment.grades
    @groups = @assignment.groups
    @title = "View #{@assignment.name}"
    @teams = current_course.teams
    @assignment_submissions = @assignment.assignment_submissions
    @earnables = current_course.earned_badges.all
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @students = current_course.users.students.includes(:teams).where(user_search_options)
    respond_with @assignment    
  end

  def new
    @title = "Create a New Assignment"
    @assignment = current_course.assignments.new
    @assignment_types = current_course.assignment_types.all
    @grade_schemes = current_course.grade_schemes
  end

  def edit
    @assignment = current_course.assignments.find(params[:id])
    @assignment_types = current_course.assignment_types.all
    @grade_schemes = current_course.grade_schemes.all
    @title = "Edit #{@assignment.name}"
    respond_with @assignment = current_course.assignments.find(params[:id])
  end

  def create
    @assignment = current_course.assignments.new(params[:assignment])
    if @assignment.save
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully created.'
    else
      respond_with @assignment
    end
  end

  def update
    @assignment = current_course.assignments.find(params[:id])
    if @assignment.update_attributes(params[:assignment])
      respond_with @assignment, :location => assignment_path(@assignment), :notice => 'Assignment was successfully updated.'
    else
      respond_with @assignment
    end
  end

  def destroy
    @assignment = current_course.assignments.find(params[:id])
    @assignment.destroy
    
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :ok }
    end
  end
end
