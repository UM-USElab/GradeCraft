class AddOpenDateToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :open_date, :datetime
  end
end
