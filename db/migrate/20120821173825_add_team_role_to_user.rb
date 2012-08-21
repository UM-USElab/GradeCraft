class AddTeamRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :team_role, :string
  end
end
