class AddTypeToChallengeScore < ActiveRecord::Migration
  def up
    add_column :challenge_scores, :type, :string
  end
  
  def down
    remove_column :challenge_scores, :type
  end

end
