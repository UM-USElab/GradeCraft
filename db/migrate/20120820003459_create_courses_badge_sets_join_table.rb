class CreateCoursesBadgeSetsJoinTable < ActiveRecord::Migration
  def change
    create_table :courses_badge_sets, :id => false do |t|
      t.integer :course_id
      t.integer :badge_set_id
    end
  end

end
