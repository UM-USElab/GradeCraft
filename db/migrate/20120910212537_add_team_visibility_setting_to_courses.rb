class AddTeamVisibilitySettingToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :teams_visible, :boolean
  end
end
