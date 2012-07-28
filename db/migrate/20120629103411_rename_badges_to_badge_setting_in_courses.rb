class RenameBadgesToBadgeSettingInCourses < ActiveRecord::Migration
  def change  
    add_column :courses, :badges, :badge_setting, :integer
  end

end
