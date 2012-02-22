class ChangeScoreToSortableScoreTeam < ActiveRecord::Migration
  def change
    rename_column :teams, :score, :sortable_score
  end
end
