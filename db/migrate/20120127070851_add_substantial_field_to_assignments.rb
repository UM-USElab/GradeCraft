class AddSubstantialFieldToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :substantial, :boolean, :default => false
  end

  def down
    remove_column :assignments, :substantial
  end
end
