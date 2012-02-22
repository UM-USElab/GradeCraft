class AddDynamicToGradeSchemes < ActiveRecord::Migration
  def change
    add_column :grade_schemes, :grade_name, :string
    add_column :grade_schemes, :range_bottom, :integer
    add_column :grade_schemes, :range_top, :integer  
  end
end
