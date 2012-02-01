class ChangeAssignmentIdInGradeScheme < ActiveRecord::Migration
  def up
    remove_column :grade_scheme, :assignment_id
    add_column :grade_scheme, :assignment
  end

  def down
    add_column :grade_scheme, :assignment_id
    remove_column :grade_scheme, :assignment
  end
end
