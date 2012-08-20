class RenameCourseBadgeSetsTable < ActiveRecord::Migration
  def change 
    rename_table :courses_badge_sets, :badge_sets_courses
  end

end
