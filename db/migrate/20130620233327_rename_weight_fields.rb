class RenameWeightFields < ActiveRecord::Migration
  def up
    rename_column :courses, :user_weight_amount, :max_student_weight
    rename_column :courses, :user_weight_amount_type, :student_weight_type
    rename_column :courses, :user_weight_amount_close_date, :student_weight_close_date
    Course.where('max_student_weight is NULL').update_all(:max_student_weight => 0)
    change_column :courses, :max_student_weight, :integer, :null => false
    add_column :assignment_types, :student_weightable, :boolean
  end

  def down
    remove_column :assignment_types, :student_weightable
    change_column :courses, :max_student_weight, :integer
    rename_column :courses, :student_weight_close_date, :user_weight_amount_close_date
    rename_column :courses, :student_weight_type, :user_weight_amount_type
    rename_column :courses, :max_student_weight, :user_weight_amount
  end
end
