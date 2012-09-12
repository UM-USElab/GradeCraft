class AddBadgeUseToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :badge_use_scope, :string
    add_column :assignments, :badge_set_id, :integer
  end
end
