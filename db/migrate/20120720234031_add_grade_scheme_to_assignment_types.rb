class AddGradeSchemeToAssignmentTypes < ActiveRecord::Migration
  def change
    add_column :assignment_types, :grade_scheme_id, :integer
  end
end
