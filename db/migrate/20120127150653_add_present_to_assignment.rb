class AddPresentToAssignment < ActiveRecord::Migration
  def up
    add_column :assignments, :present, :boolean
  end

  def down
    remove_column :assignments, :present
  end
end
