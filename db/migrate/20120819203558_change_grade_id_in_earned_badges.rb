class ChangeGradeIdInEarnedBadges < ActiveRecord::Migration
  def change 
    rename_column :earned_badges, :grade_id, :earnable_id 
    add_column :earned_badges, :earnable_type, :string
  end
end
