class RenameBadgesToBadgeSettingInCourses < ActiveRecord::Migration
  def change  
    add_column :courses, :badge_setting, :integer
  end

end
