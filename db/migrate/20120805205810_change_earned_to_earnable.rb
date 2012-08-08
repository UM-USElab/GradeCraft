class ChangeEarnedToEarnable < ActiveRecord::Migration
  def change 
    rename_column :earned_badges, :earned_id, :earnable_id
    rename_column :earned_badges, :earned_type, :earnable_type
  end

end
