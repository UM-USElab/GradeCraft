class AddTeamRoleSettingToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :team_roles, :boolean
  end
end
