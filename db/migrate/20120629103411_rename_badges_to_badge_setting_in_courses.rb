class RenameBadgesToBadgeSettingInCourses < ActiveRecord::Migration
  def change  
    rename_column :courses, :badges, :badge_setting, :integer
  end

end
