class AddScoreToUser < ActiveRecord::Migration
  def up
    add_column :users, :score, :numeric
  end
  
  def down
    remove_column :users, :score
  end
end
