class AddStatusToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :status, :boolean, :default => 1
  end
end
