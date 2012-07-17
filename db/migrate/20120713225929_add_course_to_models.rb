class AddCourseToModels < ActiveRecord::Migration
  def change
    add_column :teams, :course_id, :integer
    add_column :assignments, :course_id, :integer 
    add_column :challenges, :course_id, :integer
  end
end
