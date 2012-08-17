class AssignmentSubmissionsController < ApplicationController
  def index
    @assignment_submissions = AssignmentSubmission.all
    respond_with(@assignment_submissions)
  end

  def show
    @assignment_submission = AssignmentSubmission.find(params[:id])
    respond_with(@assignment_submission)
  end

  def new
    @assignment_submission = AssignmentSubmission.new
    respond_with(@assignment_submission)
  end

  def edit
    @assignment_submission = AssignmentSubmission.find(params[:id])
  end

  def create
    @assignment_submission = AssignmentSubmission.new(params[:assignment_submission])
    @assignment_submission.save
    respond_with(@assignment_submission)
  end

  def update
    @assignment_submission = AssignmentSubmission.find(params[:id])
    @assignment_submission.update_attributes(params[:assignment_submission])
    respond_with(@assignment_submission)
  end

  def destroy
    @assignment_submission = AssignmentSubmission.find(params[:id])
    @assignment_submission.destroy
    respond_with(@assignment_submission)
  end
end
