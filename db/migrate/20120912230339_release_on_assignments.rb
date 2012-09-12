class ReleaseOnAssignments < ActiveRecord::Migration
  def change 
    add_column :assignments, :release_necessary, :boolean
  end

end
