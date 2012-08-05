class RemoveUserAndGradeIdsFromBadge < ActiveRecord::Migration
  def change
    remove_column :earned_badges, :user_id
    remove_column :earned_badges, :grade_id
  end
end
