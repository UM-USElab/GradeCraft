class AddEarnedBadgesTable < ActiveRecord::Migration
  def up
    create_table :earned_badges do |t|
      t.integer :grade_id
      t.integer :badge_id
      t.timestamps
    end
  end

  def down
    drop_table :earned_badges
  end
end
