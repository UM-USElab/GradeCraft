class AddBadgestoCourse < ActiveRecord::Migration
  def up
    add_column :courses, :badges, :boolean
  end

  def down
    add_column :courses, :badges
  end
end
