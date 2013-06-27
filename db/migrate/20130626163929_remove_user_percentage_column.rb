class RemoveUserPercentageColumn < ActiveRecord::Migration
  def change
    remove_column :assignment_types, :user_percentage_set
  end
end
