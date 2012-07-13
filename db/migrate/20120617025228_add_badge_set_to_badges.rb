class AddBadgeSetToBadges < ActiveRecord::Migration
  def self.up
    add_column :badges, :badge_set_id, :integer
  end  
  
  def self.down
    remove_column :badges, :badge_set_id
  end
end
