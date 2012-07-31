class AddVisitCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :visit_count, :integer
  end
end
