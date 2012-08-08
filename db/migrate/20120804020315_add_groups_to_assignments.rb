class AddGroupsToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :groups, :boolean
  end
end
