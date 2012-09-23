class CreateRubrics < ActiveRecord::Migration
  def change
    create_table :rubrics do |t|
      t.string :name
      t.integer :assignment_id
      t.text :description

      t.timestamps
    end
  end
end
