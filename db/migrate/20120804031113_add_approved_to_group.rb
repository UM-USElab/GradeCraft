class AddApprovedToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :approved, :string
    add_column :groups, :proposal, :string
  end
end
