class GradesController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?, :except=>[:self_log, :self_log_create]
  

  def index
    @title = "View All Grades"
    @assignment = Assignment.find(params[:assignment_id])
    @groups = @assignment.groups 
    @teams = current_course.teams
    @grades = @assignment.assignment_grades.where(params[:assignment_id])
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @students = current_course.users.students.includes(:teams).where(user_search_options)
  end

  def show
    @title = "View Grade"
    @grade = Grade.find(params[:id])
    @assignment = Assignment.find(params[:assignment_id])
  end
  
  def gradebook
    @title = "Class Gradebook"
    @assignments = current_course.assignments.sort_by &:id
    @students = current_course.users.students.includes(:grades)
  end

  def new 
    @title = "Submit A New Grade"
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_type = @assignment.assignment_type
    @grade = @assignment.assignment_grades.create(params[:grade])
    @grade.gradeable = params[:gradeable_type].constantize.find(params[:gradeable_id])
    @score_levels = @assignment_type.score_levels
    @earned_badges = current_course.badges.map do |b|
      EarnedBadge.where(:badge_id => b.id, :earnable_id => @grade.id, :earnable_type => 'Grade').first || EarnedBadge.new(:badge_id => b.id, :earnable_id => @grade.id, :earnable_type => 'Grade')
    end
    @teams = current_course.teams.all
    @groups = current_course.groups.all
    @students = current_course.users.students
    @grade_scheme_elements = @assignment.grade_scheme_elements
    respond_with(@grade)
  end

  def edit
    @title = "Edit Grade"
    @badges = current_course.badges.all
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_type = @assignment.assignment_type    
    @score_levels = @assignment_type.score_levels
    @students = current_course.users.students
    @teams = current_course.teams
    @grade = @assignment.assignment_grades.find(params[:id])
    @earned_badges = current_course.badges.map do |b|
      EarnedBadge.where(:badge_id => b.id, :earnable_id => @grade.id, :earnable_type => 'Grade').first || EarnedBadge.new(:badge_id => b.id, :earnable_id => @grade.id, :earnable_type => 'Grade')
    end
    @gradeable = @grade.gradeable
    #@gradeable_earned_badges = @gradeable.earned_badges
    @grade_scheme_elements = @assignment.grade_scheme_elements
    respond_with @grade
  end
  
  def create
    @gradeable = find_gradeable
    @assignment = Assignment.find(params[:assignment_id])
    @students = current_course.users.students 
    @grade = @gradeable.assignment_grades.build(params[:grade])
    @earnable = find_earnable
    @badges = current_course.badges.all
    @earned_badge = EarnedBadge.new(params[:earned_badge])
    respond_to do |format|
      if @grade.save
        format.html { redirect_to @assignment, notice: 'Grade was successfully created.' }
        format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { render action: "new" }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @assignment.assignment_grades.find(params[:id])
    @earnable = find_earnable
    @badges = current_course.badges.all
    @earned_badge = EarnedBadge.new(params[:earned_badge])
    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to @assignment, notice: 'Grade was successfully updated.' }
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
  
  def self_log
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @assignment.assignment_grades.create(params[:grade])
    @grade.gradeable = params[:gradeable_type].constantize.find(params[:gradeable_id])
  end
  
  def self_log_create
    @gradeable = find_gradeable
    @assignment = Assignment.find(params[:assignment_id])
    @grade = @gradeable.assignment_grades.build(params[:grade])
    respond_to do |format|
      if @grade.save
        format.html { redirect_to dashboard_path, notice: 'Thank you for logging your grade!' }
      else
        format.html { redirect_to dashboard_path, notice: "We're sorry, this grade could not be added." }
        
      end
    end
  end

  def mass_edit
    @assignment = Assignment.find(params[:assignment_id])
    @title = "Mass Grade #{@assignment.name}"
    @grade = @assignment.assignment_grades.create(params[:grade])
    @assignment_type = @assignment.assignment_type    
    @score_levels = @assignment_type.score_levels
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @students = current_course.users.students.includes(:teams).where(user_search_options)
    @grades = @students.map do |s|
      @assignment.assignment_grades.where(:gradeable_id => s.id, :gradeable_type => 'User').first || @assignment.assignment_grades.new(:gradeable => s, :assignment => @assignment)
    end
  end

  def mass_update
    @gradeable = find_gradeable
    @assignment = Assignment.find(params[:assignment_id])
    if @assignment.update_attributes(params[:assignment])
      redirect_to assignment_path(@assignment)
    else
      redirect_to mass_edit_assignment_grades_path(@assignment)
    end
  end
  
  def edit_status
    @assignment = Assignment.find(params[:assignment_id])
    @title = "#{@assignment.name} Grade Statuses"
    @grades = Grade.find(params[:grade_ids])
  end
  
  def update_status
    @assignment = Assignment.find(params[:assignment_id])
    @grades = Grade.find(params[:grade_ids])
    @grades.each do |grade|
      grade.update_attributes!(params[:grade].reject { |k,v| v.blank? })
    end
    flash[:notice] = "Updated grades!"
    redirect_to assignment_path(@assignment)
  end
  
  def find_gradeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def find_earnable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
