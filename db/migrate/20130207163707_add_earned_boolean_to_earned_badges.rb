class AddEarnedBooleanToEarnedBadges < ActiveRecord::Migration
  def change
    add_column :earned_badges, :earned, :boolean
  end
end
