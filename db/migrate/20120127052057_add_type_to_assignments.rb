class AddTypeToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :type, :string
  end

  def down
    remove_column :assignments, :type
  end
end
