class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.string :description
      t.integer :badge_id

      t.timestamps
    end
  end
end
