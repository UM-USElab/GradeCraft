class AddSubstantialToGrades < ActiveRecord::Migration
  def up
    add_column :grades, :substantial, :boolean
  end
  
  def down
    remove_column :grades, :substantial
  end
end
