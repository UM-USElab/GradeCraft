class AddScoreToTeam < ActiveRecord::Migration
  def up
    add_column :teams, :score, :numeric
  end
  
  def down
    remove_column :teams, :score
  end
end
