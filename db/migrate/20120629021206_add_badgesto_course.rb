class AddBadgestoCourse < ActiveRecord::Migration
  def up
    add_column :courses, :badges, :integer
  end

  def down
    add_column :courses, :badges
  end
end
