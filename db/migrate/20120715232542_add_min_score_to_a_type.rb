class AddMinScoreToAType < ActiveRecord::Migration
  def change
    add_column :assignment_types, :minimum_score, :integer
  end
end
