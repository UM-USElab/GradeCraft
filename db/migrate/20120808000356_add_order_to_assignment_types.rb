class AddOrderToAssignmentTypes < ActiveRecord::Migration
  def change
    add_column :assignment_types, :order, :integer
  end
end
