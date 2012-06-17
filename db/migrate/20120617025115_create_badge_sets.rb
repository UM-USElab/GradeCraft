class CreateBadgeSets < ActiveRecord::Migration
  def change
    create_table :badge_sets do |t|
      t.string :name
      t.string :notes

      t.timestamps
    end
  end
end
