class RenameThemesInCourses < ActiveRecord::Migration
  def change 
    rename_column :courses, :themes_id, :theme_id
  end
  
end
