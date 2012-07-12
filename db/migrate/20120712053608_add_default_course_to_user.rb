class AddDefaultCourseToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_course_id, :integer
  end
end
