class AddBadgeSettingToCourses < ActiveRecord::Migration
  def change
    change_column :courses, :badge_setting, :boolean
  end
end
