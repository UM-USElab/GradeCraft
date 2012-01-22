class DropTeamIdFromChallenges < ActiveRecord::Migration
  def up
    remove_column :challenges, :team_id
  end

  def down
    add_column :challenges, :team_id
  end
end
