class AddGroupsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :group_setting, :boolean
  end
end
