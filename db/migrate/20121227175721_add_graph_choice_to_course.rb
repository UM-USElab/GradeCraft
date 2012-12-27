class AddGraphChoiceToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :graph_display, :boolean
  end
end
