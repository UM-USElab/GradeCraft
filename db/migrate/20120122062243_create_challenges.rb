class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.integer :points
      t.integer :team_id
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
