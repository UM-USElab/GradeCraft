class RenameTeamsToTeamSettingInCourses < ActiveRecord::Migration
  def change
    rename_column :courses, :teams, :team_setting
  end

end
