class RemoveRolesFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :roles
  end

  def down
    add_column :users, :roles
  end
end
