class RenameGradeSchemesInAssignment < ActiveRecord::Migration
  def change 
    rename_column :assignments, :grade_schemes_id, :grade_scheme_id
  end
end
