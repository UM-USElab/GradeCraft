class AssignmentSubmissionsController < ApplicationController
  def index
    @assignment = Assignment.find(params[:assignment_id])
    @title = "View All Submissions for #{@assignment.title}"
    @assignment_submissions = @assignment.assignment_submissions.where(params[:assignment_id])
  end

  def show
    @title = "View Submission"
    @assignment = Assignment.find(params[:assignment_id])
    @assignment_submission = AssignmentSubmission.find(params[:id])
    respond_with(@assignment_submission)
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @title = "Submit #{@assignment.title}"
    @assignment_submission = AssignmentSubmission.new
    respond_with(@assignment_submission)
  end

  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @title = "Edit Submission for #{@assignment.title}"
    @assignment_submission = AssignmentSubmission.find(params[:id])
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
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
