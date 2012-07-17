class ChangeDueDateFieldAType < ActiveRecord::Migration
  def change 
    change_column :assignment_types, :due_date, :boolean
  end
end
