class AddTypeToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :assignment_type_id, :integer
  end
end
