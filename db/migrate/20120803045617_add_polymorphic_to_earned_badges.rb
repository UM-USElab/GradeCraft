class AddPolymorphicToEarnedBadges < ActiveRecord::Migration
  def change
    add_column :earned_badges, :earned_id, :integer
    add_column :earned_badges, :earned_type, :string
  end
end
