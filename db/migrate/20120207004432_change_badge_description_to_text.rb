class ChangeBadgeDescriptionToText < ActiveRecord::Migration
  def up
    change_column :badges, :description, :text, :limit => nil
  end

  def down
    change_column :badges, :description, :string
  end
end

