class ChangeBadgeIdInCourse < ActiveRecord::Migration
  def change
    change_column :courses, :badge_sets_id, :badge_set_id
  end
end
