class AddOpenTimeToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :open_time, :datetime
  end
end
