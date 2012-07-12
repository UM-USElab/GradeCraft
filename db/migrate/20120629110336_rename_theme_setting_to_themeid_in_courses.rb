class RenameThemeSettingToThemeidInCourses < ActiveRecord::Migration
  def up
    rename_column :courses, :theme_setting, :themes_id
    rename_column :courses, :badgeset, :badge_sets_id
  end

  def down
    rename_column :courses, :themes_id, :theme_setting
    rename_column :courses, :badge_sets_id, :badgeset
  end
end
