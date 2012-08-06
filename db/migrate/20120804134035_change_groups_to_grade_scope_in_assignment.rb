class ChangeGroupsToGradeScopeInAssignment < ActiveRecord::Migration
  def change  
    rename_column :assignments, :groups_present, :grade_scope
  end

end
