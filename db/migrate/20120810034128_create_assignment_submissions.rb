class CreateAssignmentSubmissions < ActiveRecord::Migration
  def change
    create_table :assignment_submissions do |t|
      t.integer :assignment_id
      t.integer :user_id
      t.integer :group_id
      t.string :feedback
      t.string :comment

      t.timestamps
    end
  end
end
