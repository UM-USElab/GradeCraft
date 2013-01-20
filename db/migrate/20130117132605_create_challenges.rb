class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :description
      t.integer :point_total
      t.datetime :due_date
      t.integer :course_id
      t.string :points_predictor_display
      t.boolean :visible
      t.boolean :has_challenge_submissions
      t.boolean :release_necessary

      t.timestamps
    end
  end
end
