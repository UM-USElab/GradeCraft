class GradesController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?

  helper_method :sort_column, :sort_direction

  def index
    @title = "View All Grades"
    respond_with @grades = Grade.find(:all, :order => (sort_column + " " + sort_direction))
  end

  def show
    @title = "View Grade"
    respond_with @grade = Grade.find(params[:id])
  end

  def new
    @badges = Badge.all
    @teams = Team.all
    @title = "Submit New Grade"
    @assignment = Assignment.find(params[:assignment_id])
    @grade = grade_class(@assignment).new
    @grade.user = User.students.find(params[:user_id]) if params[:user_id]
    @grade.assignment = @assignment
    respond_with @grade
  end
  
  def grade_class(assignment)
    case assignment
    when ReadingReaction
      ReadingReactionGrade
    when Blogging
      BloggingGrade
    when Attendance
      AttendanceGrade
    when Standard
      StandardGrade
    else
      Grade
    end
  end

  def edit
    @title = "Edit Grade"
    respond_with @grade = Grade.find(params[:id])
  end

  def create
    @grade = Grade.new(params[:grade])
    @users = User.all
    @badges = Badge.all
    @teams = Team.all

    respond_to do |format|
      if @grade.save
        format.html { redirect_to @grade, notice: 'Grade was successfully created.' }
        format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { render action: "new" }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to @grade, notice: 'Grade was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to grades_url }
      format.json { head :ok }
    end
  end

  def mass_edit
    @assignment = Assignment.find(params[:assignment_id])
    user_search_options = {}
    if params[:team_id].present?
      @team = Team.find(params[:team_id])
      user_search_options[:team_id] = @team.id if @team
    end
    @grades = User.students.where(user_search_options).map { |s| @assignment.grades.find_or_create_by_user_id(s.id) }
  end

  def mass_update
    @assignment = Assignment.find(params[:assignment_id])
    if @assignment.update_attributes(params[:assignment])
      respond_with @assignment, :location => assignment_path(@assignment)
    else
      respond_with @assignment, :location => mass_edit_grades_path(:assignment_id => @assignment)
    end
  end

  def sort_column
    Grade.column_names.include?(params[:sort]) ? params[:sort] : "assignment_id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
