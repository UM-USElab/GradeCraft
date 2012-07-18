class AddAssignmentToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :assignment_id, :integer
  end
end
