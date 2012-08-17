class AddStudentSetToAssignmentTypes < ActiveRecord::Migration
  def change
    add_column :user_assignment_type_weights, :user_id, :integer
    add_column :user_assignment_type_weights, :assignment_type_id, :integer
    add_column :user_assignment_type_weights, :value, :integer
    add_column :courses, :user_weight_amount, :integer
  end
end
