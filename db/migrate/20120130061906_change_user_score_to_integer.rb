class ChangeUserScoreToInteger < ActiveRecord::Migration
  def up
    change_column :users, :score, :integer
  end

  def down
    change_column :users, :score, :decimal
  end
end
