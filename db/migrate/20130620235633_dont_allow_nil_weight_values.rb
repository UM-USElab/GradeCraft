class DontAllowNilWeightValues < ActiveRecord::Migration
  def up
    change_column :user_assignment_type_weights, :value, :integer, :null => false
  end

  def down
    change_column :user_assignment_type_weights, :value, :integer
  end
end
