class ChangeCourseMultiplierDefaultType < ActiveRecord::Migration
  def up
    change_column :courses, :multiplier_default, :numeric
  end

  def down
    change_column :courses, :multiplier_default, :integer
  end
end
