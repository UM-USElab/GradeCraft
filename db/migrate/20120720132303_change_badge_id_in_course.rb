class ChangeBadgeIdInCourse < ActiveRecord::Migration
  def change
    add_column :courses, :badge_set_id, :integer
  end
end
