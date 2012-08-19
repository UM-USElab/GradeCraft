class GradesController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?

  #TODO assignment_grades is undefined?
  def index
    @grades = @assignment.assignment_grades.find(params[:assignment_id])
    @title = "View All Grades"
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grades }
    end
  end

  def show
    @title = "View Grade"
    @grade = Grade.find(params[:id])
    @assignment = Assignment.find(params[:assignment_id])
    @earned_badges = EarnedBadge.all
  end
  
  def gradebook
    @title = "Class Gradebook"
    @assignments = Assignment.all.sort_by &:id
    @grades = Grade.all.sort_by &:assignment_id
    @users = current_course.users.all
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @assignment.assignment_grades.create(params[:grade])
    @badges = current_course.badges.all
    @teams = current_course.teams.all
    @students = current_course.users.students
    @grade_schemes = current_course.grade_schemes.all
    @title = "Submit A New Grade"
    respond_with @grade
  end

  def edit
    @title = "Edit Grade"
    @badges = current_course.badges.all
    @assignment = Assignment.find(params[:assignment_id])
    @assignments = current_course.assignments.all
    @students = current_course.users.students
    @grade = @assignment.assignment_grades.find(params[:id])
    respond_with @grade = Grade.find(params[:id])
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @assignment.assignment_grades.create(params[:grade])

    respond_to do |format|
      if @grade.save
        format.html { redirect_to([@assignment.id], :notice => 'Grade was successfully created.') }
        format.json { render :xml => @grade, :status => :created, :location => @grade }
      else
        format.html { render action: "new" }
        format.json { render :xml => @grade.errors, :notice => 'Grade could not be submitted properly.', :status => :unprocessable_entity }
      end
    end
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])
    #@grade = @assignment.assignment_grades.find(params[:grade])
    @grade = Grade.find(params[:id])
    #@user = @grade.find(params[:user_id])
    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to assignment_grade_path("assignment_id" => @assignment.id, "id" => @grade.id), notice: 'Grade was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @assignment.assignment_grades.find(params[:id])
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to assignment_path(@assignment), notice: 'Grade was successfully deleted.' }
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
    @students = current_course.users.students.where(user_search_options)
    @grades = @students.map do |s| 
      @assignment.grades.find_by_user_id(s.id) || grade_class(@assignment).create(:user => s, :assignment_id => @assignment.id) 
    end
  end

  def mass_update
    @assignment = Assignment.find(params[:assignment_id])
    if @assignment.update_attributes(params[:assignment])
      respond_with @assignment, :location => assignment_path(@assignment)
    else
      respond_with @assignment, :location => mass_edit_assignment_grades_path(:assignment_id => @assignment)
    end
  end
  
  def edit_status
    #TODO check
    @title = grade.assignment.name
    @grades = Grade.find(params[:grade_ids])
    #@assignments = Assignment.find(params[:assignment_id])
  end
  
  def update_status
    #@assignment = Assignment.find(params[:assignment_id])
    @grades = Grade.find(params[:grade_ids])
    @grades.each do |grade|
      grade.update_attributes!(params[:grade].reject { |k,v| v.blank? })
    end
    flash[:notice] = "Updated grades!"
    redirect_to assignments_path
  end
  
  def find_gradeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
