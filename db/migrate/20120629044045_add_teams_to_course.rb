class AddTeamsToCourse < ActiveRecord::Migration
  def up
    add_column :courses, :teams, :boolean
  end

  def down
    remove_column :courses, :teams
  end
end
