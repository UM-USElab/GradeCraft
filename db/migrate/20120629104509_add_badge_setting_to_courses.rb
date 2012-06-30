class AddBadgeSettingToCourses < ActiveRecord::Migration
  def up 
    add_column :courses, :badge_setting, :boolean, :default => 1
  end
  
  def down 
    remove_column :courses, :badge_setting
  end
end
