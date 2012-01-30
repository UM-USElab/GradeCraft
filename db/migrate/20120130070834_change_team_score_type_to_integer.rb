class ChangeTeamScoreTypeToInteger < ActiveRecord::Migration
  def up
    change_column :teams, :score, :integer
  end

  def down
    change_column :teams, :score, :decimal
  end
end
