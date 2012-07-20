class ChangeAssignmentTypeToString < ActiveRecord::Migration
  def change 
    change_column :assignments, :type, :integer
  end
end
