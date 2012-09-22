class AddTeamToAssignmentSubmission < ActiveRecord::Migration
  def change
    add_column :assignment_submissions, :submittable_id, :integer
    add_column :assignment_submissions, :submittable_type, :string
    remove_column :assignment_submissions, :group_id
  end
end
