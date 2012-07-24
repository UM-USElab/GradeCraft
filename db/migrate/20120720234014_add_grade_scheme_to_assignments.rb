class AddGradeSchemeToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :grade_scheme_id, :integer
  end
end
