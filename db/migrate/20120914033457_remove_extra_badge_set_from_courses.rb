class RemoveExtraBadgeSetFromCourses < ActiveRecord::Migration
  def change 
    remove_column :courses, :badge_sets_id
  end

end
