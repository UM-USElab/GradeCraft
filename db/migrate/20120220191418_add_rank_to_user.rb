class AddRankToUser < ActiveRecord::Migration
  def up
    add_column :users, :rank, :integer
  end
  
  def down
    remove_column :users, :rank
  end
end
