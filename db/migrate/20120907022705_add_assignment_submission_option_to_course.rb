class AddAssignmentSubmissionOptionToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :assignment_submissions, :boolean
    add_column :assignments, :assignment_submissions, :boolean
    add_column :assignments, :student_logged, :boolean
    add_column :assignments, :student_logged_button_text, :string
  end
end
