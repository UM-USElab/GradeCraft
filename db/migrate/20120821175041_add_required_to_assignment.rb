class AddRequiredToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :required, :boolean
  end
end
