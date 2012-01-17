class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :description
      t.integer :point_total
      t.datetime :due_date

      t.timestamps
    end
  end
end
