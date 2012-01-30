class AddSemisAndFinalistToGrades < ActiveRecord::Migration
  def up
     add_column :grades, :complete, :boolean
     add_column :grades, :semis, :boolean
     add_column :grades, :finals, :boolean 
  end
  
  def down
    remove_column :grades, :complete
    remove_column :grades, :semis
    remove_column :grades, :finals
  end
end
