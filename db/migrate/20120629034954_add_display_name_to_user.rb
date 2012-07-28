class AddDisplayNameToUser < ActiveRecord::Migration
  def up
    add_column :users, :display_name, :string
    add_column :users, :private_display, :boolean
  end

  def down
    remove_column :users, :display_name
    remove_column :users, :private_display
  end
end
