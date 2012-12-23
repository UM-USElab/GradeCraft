class AddPublicBadgesToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :shared_badges, :boolean
    add_column :course_memberships, :shared_badges, :string
    add_column :earned_badges, :shared, :boolean
  end
end
