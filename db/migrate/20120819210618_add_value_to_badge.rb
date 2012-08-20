class AddValueToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :value, :integer
    add_column :badges, :multiplier, :integer
  end
end
