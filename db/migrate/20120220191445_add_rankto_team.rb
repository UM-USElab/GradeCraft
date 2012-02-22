class AddRanktoTeam < ActiveRecord::Migration
  def up
    add_column :teams, :rank, :integer
  end
  
  def down
    remove_column :teams, :rank
  end
end
