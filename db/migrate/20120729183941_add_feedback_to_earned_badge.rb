class AddFeedbackToEarnedBadge < ActiveRecord::Migration
  def change
    add_column :earned_badges, :feedback, :string
  end
end
