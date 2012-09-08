class AddNameToGradeScheme < ActiveRecord::Migration
  def change
    add_column :grade_schemes, :name, :string
    remove_column :grade_schemes, :grade_name
    remove_column :grade_schemes, :range_bottom
    remove_column :grade_schemes, :range_top
  end
end
