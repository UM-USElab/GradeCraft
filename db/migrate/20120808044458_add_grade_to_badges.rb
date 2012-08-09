class AddGradeToBadges < ActiveRecord::Migration
  def change
    add_column :earned_badges, :grade_id, :integer
    remove_column :earned_badges, :earnable_id
    remove_column :earned_badges, :earnable_type
  end
end
