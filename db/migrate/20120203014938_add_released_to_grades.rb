class AddReleasedToGrades < ActiveRecord::Migration
  def up
    add_column :grades, :status, :string
  end
  
  def down
    remove_column :grades, :status
  end
end
