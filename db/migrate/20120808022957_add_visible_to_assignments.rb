class AddVisibleToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :visible, :string
  end
end
