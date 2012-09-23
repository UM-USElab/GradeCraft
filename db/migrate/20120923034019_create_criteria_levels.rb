class CreateCriteriaLevels < ActiveRecord::Migration
  def change
    create_table :criteria_levels do |t|
      t.string :name
      t.integer :criteria_id
      t.text :description
      t.integer :value

      t.timestamps
    end
  end
end
