class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.string :name
      t.integer :ruberic_id
      t.text :description

      t.timestamps
    end
  end
end
