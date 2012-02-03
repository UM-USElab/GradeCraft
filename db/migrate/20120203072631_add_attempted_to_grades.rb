class AddAttemptedToGrades < ActiveRecord::Migration
  def up
    add_column :grades, :attempted, :boolean
  end
  
  def down
    add_column :grades, :attempted
  end
end
