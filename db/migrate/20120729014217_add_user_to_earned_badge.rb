class AddUserToEarnedBadge < ActiveRecord::Migration
  def change
    add_column :earned_badges, :user_id, :integer
  end
end
