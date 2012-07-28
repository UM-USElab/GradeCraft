class DropCkEditor < ActiveRecord::Migration
  def up
    drop_table :ckeditor_assets
  end

  def down
    add_table :ckeditor_assets
  end
end
