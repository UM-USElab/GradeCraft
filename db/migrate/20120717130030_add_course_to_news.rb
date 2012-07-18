class AddCourseToNews < ActiveRecord::Migration
  def change
    add_column :news, :course_id, :integer
    add_column :groups, :course_id, :integer
  end
end
