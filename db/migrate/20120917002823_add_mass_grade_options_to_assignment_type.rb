class AddMassGradeOptionsToAssignmentType < ActiveRecord::Migration
  def change
    add_column :assignment_types, :mass_grade_type, :string
  end
end
