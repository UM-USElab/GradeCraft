class ChangeScoreToSortableScoreUser < ActiveRecord::Migration
    def change
    rename_column :users, :score, :sortable_score
  end
end
