class ChangeAssignmentSubmissionFieldInAssignmentsandCourses < ActiveRecord::Migration
  def up
    rename_column :assignments, :assignment_submissions, :has_assignment_submissions
    rename_column :courses, :assignment_submissions, :has_assignment_submissions
  end

  def down
  end
end
