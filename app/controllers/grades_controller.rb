class GradesController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?

  def index
    @grades = Grades.find(params[:assignment_id])
    @title = "View All Grades"
    @grades = current_course.grades.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grades }
    end
  end

  def show
    @title = "View Grade"
    @grade = Grade.find(params[:id])
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
    @title = "Submit New Grade"
    #@assignment = Assignment.find(params[:assignment_id]) if params[:assignment_id]
    #@grade.user = User.students.find(params[:user_id]) if params[:user_id]
    #@grade.assignment = @assignment
    #respond_with @grade
  end
  
  def grade_class(assignment)
#     case assignment
#     when ReadingReaction
#       ReadingReactionGrade
#     when Blogging
#       BloggingGrade
#     when Attendance
#       AttendanceGrade
#     when LFPG
#       LFPGGrade
#     when BossBattle
#       BossBattleGrade
#     when TeamAssignment
#       TeamAssignmentGrade
#     else
       Grade
#     end
  end

  def edit
    @title = "Edit Grade"
    @badges = current_course.badges.all
    respond_with @grade = Grade.find(params[:id])
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @assignment.grades.create(params[:grade])
    @users = current_course.users.all
    @badges = current_course.badges.all
    @teams = current_course.teams.all
    
    respond to do |format|
      if @grade.save
        format.html { redirect_to([@assignment, @grade], :notice => 'Grade was successfully created.') }
        format.json { render :xml => @grade, :status => :created, :location => @grade }
      else
        format.html { render :action => "new" }
        format.json { render :xml => @grade.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to assignment_grades_path(@grade), notice: 'Grade was successfully updated.' }
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

end
