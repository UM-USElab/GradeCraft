class AddGradeToEarnedBadge < ActiveRecord::Migration
  def change
    add_column :earned_badges, :grade_id, :integer
  end
end
