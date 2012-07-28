class RemoveTypeFromAssignments < ActiveRecord::Migration
  def up
    remove_column :assignments, :type
  end

  def down
    add_column :assignments, :type
  end
end
