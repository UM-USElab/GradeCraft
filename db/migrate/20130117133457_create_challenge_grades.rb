class CreateChallengeGrades < ActiveRecord::Migration
  def change
    create_table :challenge_grades do |t|
      t.integer :challenge_id
      t.integer :score
      t.string :feedback
      t.boolean :status
      t.integer :team_id
      t.integer :final_score

      t.timestamps
    end
  end
end
