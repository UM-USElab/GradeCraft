class AddOccuranceToBadges < ActiveRecord::Migration
  def up
    add_column :grades, :occurance, :string
  end
  
  def down
    remove_column :grades, :occurance
  end
end
