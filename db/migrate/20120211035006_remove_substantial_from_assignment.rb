class RemoveSubstantialFromAssignment < ActiveRecord::Migration
  def up
    remove_column :assignments, :substantial
  end

  def down
    add_column :assignments, :substantial
  end
end
