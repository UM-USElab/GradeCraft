class RemoveSortableScoreFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :sortable_score
  end

  def down
    add_column :users, :sortable_score, :integer
  end
end
