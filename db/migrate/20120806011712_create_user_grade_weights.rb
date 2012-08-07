class CreateUserGradeWeights < ActiveRecord::Migration
  def change
    create_table :user_grade_weights do |t|

      t.timestamps
    end
  end
end
