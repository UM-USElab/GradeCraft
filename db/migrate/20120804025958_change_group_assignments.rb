class ChangeGroupAssignments < ActiveRecord::Migration
  def change 
    rename_column :assignments, :groups, :groups_present
  end

end
