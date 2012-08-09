class RenameOrderInAssignmentTypes < ActiveRecord::Migration
  def change 
    rename_column :assignment_types, :order, :order_placement
  end

end
