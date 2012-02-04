class AddAPlusToGradeScheme < ActiveRecord::Migration
  def up
    add_column :grade_schemes, :apscore, :integer
  end
  
  def down
    remove_column :grade_schemes, :apscore
end
