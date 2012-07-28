class AddStatusToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :status, :boolean
  end
end
