class ChangeGsInAssignment < ActiveRecord::Migration
  def change 
    rename_column :assignments, :grade_scheme_id, :grade_schemes_id
  end

end
