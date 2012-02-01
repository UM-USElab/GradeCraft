class AddTypeToGrade < ActiveRecord::Migration
  def up
    add_column :grades, :type, :string
  end
  
  def down
    remove_column :grades, :type
  end
end
