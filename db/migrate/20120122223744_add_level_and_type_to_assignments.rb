class AddLevelAndTypeToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :level, :string
    add_column :assignments, :type, :string
  end
  
  def self.down
    remove_column :assignments, :level, :string
    remove_column :assignments, :type, :string
  end
end
