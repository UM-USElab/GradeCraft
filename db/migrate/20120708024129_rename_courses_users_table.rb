class RenameCoursesUsersTable < ActiveRecord::Migration
  def change
    rename_table :courses_users, :courses_membership
  end
end
