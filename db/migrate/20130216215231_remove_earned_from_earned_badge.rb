class RemoveEarnedFromEarnedBadge < ActiveRecord::Migration
  def up
    remove_column :earned_badges, :earned
  end

  def down
    add_column :earned_badges, :earned, :boolean
  end
end
