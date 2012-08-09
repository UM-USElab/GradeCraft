class AddTimeToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :close_time, :datetime
  end
end
