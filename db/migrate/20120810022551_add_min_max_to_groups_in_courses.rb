class AddMinMaxToGroupsInCourses < ActiveRecord::Migration
  def change
    add_column :courses, :min_size, :integer
    add_column :courses, :max_size, :integer
  end
end
