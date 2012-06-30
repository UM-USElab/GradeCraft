class RenameBadgesInCourses < ActiveRecord::Migration
  def up 
    remove_column :courses, :badges
  end
  
  def down 
    add_column :courses, :badges
  end
end
