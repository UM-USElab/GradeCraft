class RenameThemesToThemeSettingInCourses < ActiveRecord::Migration
  def change
    rename_column :courses, :theme, :theme_setting
  end

end
