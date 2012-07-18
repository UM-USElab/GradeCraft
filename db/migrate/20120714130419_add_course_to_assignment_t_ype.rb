class AddCourseToAssignmentTYpe < ActiveRecord::Migration
  def change
    add_column :assignment_types, :course_id, :integer
  end
end
