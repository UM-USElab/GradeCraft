class AddStepValueToAType < ActiveRecord::Migration
  def change
    add_column :assignment_types, :step_value, :integer, :default => 1
  end
end
