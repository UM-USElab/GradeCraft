class AddPageViewsToUser < ActiveRecord::Migration
  def change
    add_column :users, :predictor_views, :integer
    add_column :users, :page_views, :integer
  end
end
