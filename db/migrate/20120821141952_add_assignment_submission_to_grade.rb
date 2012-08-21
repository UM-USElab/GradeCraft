class AddAssignmentSubmissionToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :assignment_submission_id, :integer
  end
end
