class AddPointsToAType < ActiveRecord::Migration
  def change
    add_column :assignment_types, :universal_point_value, :integer
  end
end
