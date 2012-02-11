class RenameOccuranceInBadges < ActiveRecord::Migration
  def up
    remove_column :grades, :occurance
  end

  def down
    add_column :grades, :occurance
  end
end
