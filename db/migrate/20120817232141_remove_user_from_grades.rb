class RemoveUserFromGrades < ActiveRecord::Migration
  def change 
    remove_column :grades, :user_id
    remove_column :grades, :badge_id
  end
end
