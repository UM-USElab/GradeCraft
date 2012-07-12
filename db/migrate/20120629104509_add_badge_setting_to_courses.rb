class AddBadgeSettingToCourses < ActiveRecord::Migration
  def change
    change_column :courses, :badge_setting, :boolean, :default => 1
  end
end
