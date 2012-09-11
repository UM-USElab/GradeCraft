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
    enforce_view_permission(@assignment_submission)
    respond_with(@assignment_submission)
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @title = "Submit #{@assignment.name}"
    @users = current_course.users
    @assignment_submission = AssignmentSubmission.new
    @assignment_submission.user_id = params[:user_id]
    respond_with(@assignment_submission)
  end

  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @title = "Edit Submission for #{@assignment.name}"
    @assignment_submission = AssignmentSubmission.find(params[:id])
    @assignment_submission = @assignment.assignment_submissions.find(params[:id])
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_submission = @assignment.assignment_submissions.build(params[:assignment_submission])
    @assignment_submission.save
    respond_to do |format|
      if @assignment_submission.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully submitted.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @assignment_submission = AssignmentSubmission.find(params[:id])
    @assignment_submission.update_attributes(params[:assignment_submission])
    respond_with(@assignment_submission)
  end

  def destroy
    debugger
    @assignment_submission = AssignmentSubmission.find(params[:id])
    @assignment_submission.destroy
    respond_with(@assignment)
  end
end
