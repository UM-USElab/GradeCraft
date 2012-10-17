class AddIdToCourseMemberships < ActiveRecord::Migration
  def change
    add_column :course_memberships, :id, :primary_key
  end
end
