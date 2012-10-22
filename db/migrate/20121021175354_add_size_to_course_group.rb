class AddSizeToCourseGroup < ActiveRecord::Migration
  def change
    add_column :courses, :max_group_size, :integer
    add_column :courses, :min_group_size, :integer
  end
end
