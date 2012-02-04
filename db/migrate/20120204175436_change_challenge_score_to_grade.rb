class ChangeChallengeScoreToGrade < ActiveRecord::Migration
  def change
    rename_table(:challenge_scores, :challenge_grades)
  end
end
