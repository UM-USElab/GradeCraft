class AddScoreIndexToUsers < ActiveRecord::Migration
  def change
    add_index(:users, :sortable_score, :name => 'index_users_sortable_score')
  end
end
