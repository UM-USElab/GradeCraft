class StandardizeWeightSizeMethodsOnCourse < ActiveRecord::Migration
  def change
    rename_column :courses, :max_student_weight, :total_student_weight
    rename_column :courses, :max_size, :max_student_assignment_type_weight
    remove_column :courses, :min_size, :integer
    rename_table :user_assignment_type_weights, :student_assignment_type_weights
    rename_column :student_assignment_type_weights, :value, :weight
    rename_column :student_assignment_type_weights, :user_id, :student_id
  end
end
