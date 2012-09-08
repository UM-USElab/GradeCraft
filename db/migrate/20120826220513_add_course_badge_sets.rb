class AddCourseBadgeSets < ActiveRecord::Migration
  def up
    create_table :course_badge_sets do |t|
      t.references :course
      t.references :badge_set
    end
  end

  def down
    drop_table :course_badge_sets
  end
end
