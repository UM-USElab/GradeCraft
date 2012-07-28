class RemoveDueDateFromAType < ActiveRecord::Migration
  def up
    remove_column :assignment_types, :due_date
    add_column :assignment_types, :due_date_present, :boolean
  end

  def down
    add_column :assignment_types, :due_date
    remove_column :assignment_types, :due_date_present
  end
end
