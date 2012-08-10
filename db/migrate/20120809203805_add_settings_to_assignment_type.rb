class AddSettingsToAssignmentType < ActiveRecord::Migration
  def change
    add_column :assignment_types, :user_percentage_set, :string
  end
end
