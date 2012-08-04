class ChangeGroupsTypeAssignments < ActiveRecord::Migration
  def change 
    change_column :assignments, :groups, :string
  end

end
