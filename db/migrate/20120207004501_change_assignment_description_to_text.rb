class ChangeAssignmentDescriptionToText < ActiveRecord::Migration
  def up
    change_column :assignments, :description, :text, :limit => nil
  end

  def down
    change_column :assignments, :description, :string
  end
end
