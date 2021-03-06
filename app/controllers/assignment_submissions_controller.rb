class AssignmentSubmissionsController < ApplicationController

  before_filter :ensure_staff?, :only=>[:index]

  def index
    @assignment = Assignment.find(params[:assignment_id])
    @title = "View All Submissions for #{@assignment.name}"
    @assignment_submissions = @assignment.assignment_submissions.where(params[:assignment_id])
  end

  def show
    @title = "View Submission"
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_submission = AssignmentSubmission.find(params[:id])
    if current_user.is_student?
      enforce_view_permission(@assignment_submission)
    end
    @assignment_type = @assignment.assignment_type
    
    if current_user.is_staff?
      @gradeable = params[:gradeable_type].constantize.find(params[:gradeable_id])
      if @gradeable.grade_for_assignment(@assignment)
        @grade = @assignment.assignment_grades.find(params[:grade_id])
      else 
        @grade = @assignment.assignment_grades.create(params[:grade])
      end
      @score_levels = @assignment_type.score_levels
      @earned_badges = current_course.badges.map do |b|
      EarnedBadge.where(:badge_id => b.id, :earnable_id => @grade.id, :earnable_type => 'Grade').first || EarnedBadge.new(:badge_id => b.id, :earnable_id => @grade.id, :earnable_type => 'Grade')
      @grade_scheme_elements = @assignment.grade_scheme_elements
      end
    end
    respond_with(@grade)
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @title = "Submit #{@assignment.name}"
    @users = current_course.users
    @assignment_submission = @assignment.assignment_submissions.create(params[:assignment_submission])
    @assignment_submission.submittable = params[:submittable_type].constantize.find(params[:submittable_id])
    @groups = @assignment.groups 
    @teams = current_course.teams
    @students = @users.students
    #@assignment_submission.user_id = params[:user_id]
    #respond_with(@assignment_submission)
  end

  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @students = current_course.users.students
    @groups = @assignment.groups.all 
    @teams = current_course.teams
    @title = "Edit Submission for #{@assignment.name}"
    @assignment_submission = AssignmentSubmission.find(params[:id])
    #@assignment_submission = @assignment.assignment_submissions.find(params[:id])
    #@assignment_submission = @submittable.assignment_submissions.build(params[:grade])
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_submission = @assignment.assignment_submissions.build(params[:assignment_submission])
    #@assignment_submission.save
    respond_to do |format|
      if @assignment_submission.save
        if current_user.is_student?
          format.html { redirect_to dashboard_path, notice: "#{@assignment.name} was successfully submitted." }
          format.json { render json: @assignment, status: :created, location: @assignment }
        else 
          format.html { redirect_to assignment_path(@assignment), notice: "#{@assignment.name} was successfully submitted." }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_submission = @assignment.assignment_submissions.find(params[:id])
    respond_to do |format|
      if @assignment_submission.update_attributes(params[:assignment_submission])
        format.html { redirect_to dashboard_path, notice: "Your #{@assignment.name} was successfully updated." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_submission = AssignmentSubmission.find(params[:id])
    @assignment_submission.destroy
    respond_to do |format|
      format.html { redirect_to assignment_assignment_submissions_path(@assignment), notice: 'Submission was successfully deleted.' }
      format.json { head :ok }
    end
  end
  
  def find_gradeable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
  def find_submittable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end
