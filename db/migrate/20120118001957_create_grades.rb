class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.integer :score
      t.references :user
      t.references :assignment
      t.string :feedback
      t.references :badge

      t.timestamps
    end
    add_index :grades, :user_id
    add_index :grades, :assignment_id
    add_index :grades, :badge_id
  end
end
