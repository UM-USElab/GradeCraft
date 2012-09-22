class AddMultiplierDefaultToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :multiplier_default, :integer
  end
end
