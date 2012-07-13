class RenameCoursesMembershipTable < ActiveRecord::Migration
  def change
    rename_table :courses_membership, :course_memberships
  end
end
