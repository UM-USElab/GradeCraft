class AddTypeToChallenge < ActiveRecord::Migration
  def up
    add_column :challenges, :type, :string
  end
  
  def down
    remove_column :challenges, :type
  end
end
