class RemoveNewsTable < ActiveRecord::Migration
  def change 
    drop_table :news
    drop_table :challenges
    drop_table :challenge_grades
  end

end
