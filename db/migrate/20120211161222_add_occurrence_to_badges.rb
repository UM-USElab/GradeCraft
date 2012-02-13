class AddOccurrenceToBadges < ActiveRecord::Migration
  def up
    add_column :badges, :occurrence, :string
  end
  
  def down
    remove_column :badges, :occurrence
  end
end
