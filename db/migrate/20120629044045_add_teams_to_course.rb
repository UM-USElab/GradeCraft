class AddTeamsToCourse < ActiveRecord::Migration
  def up
    add_column :courses, :teams, :boolean, :default => 0
  end

  def down
    remove_column :courses, :teams
  end
end
