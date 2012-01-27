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
    @title = "Submit New Grade"
    @grade = Grade.new
    @grade.user = User.students.find(params[:user_id]) if params[:user_id]
    @grade.assignment = Assignment.find(params[:assignment_id]) if params[:assignment_id]
    @badges = Badge.all
    @teams = Team.all
    respond_with @grade
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
    @grades = User.students.map { |s| @assignment.grades.find_or_create_by_user_id(s.id) }
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
