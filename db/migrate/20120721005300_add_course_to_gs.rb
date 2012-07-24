class AddCourseToGs < ActiveRecord::Migration
  def change
    add_column :grade_schemes, :course_id, :integer
  end
end
