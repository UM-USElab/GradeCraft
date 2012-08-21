class AddMassGradingToAssignmentType < ActiveRecord::Migration
  def change
    add_column :assignment_types, :mass_grade, :boolean
  end
end
