class CreateChallengeScores < ActiveRecord::Migration
  def change
    create_table :challenge_scores do |t|
      t.integer :score
      t.string :feedback
      t.integer :team_id
      t.integer :challenge_id

      t.timestamps
    end
  end
end
