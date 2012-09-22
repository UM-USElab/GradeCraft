class RemoveTableUserGradeWeights < ActiveRecord::Migration
  def up
    drop_table :user_grade_weights
  end

end
