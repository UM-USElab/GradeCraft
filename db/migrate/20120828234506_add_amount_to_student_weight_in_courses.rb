class AddAmountToStudentWeightInCourses < ActiveRecord::Migration
  def change
    add_column :courses, :user_weight_amount_type, :string
  end
end
