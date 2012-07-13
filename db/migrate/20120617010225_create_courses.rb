class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :courseno
      t.datetime :year
      t.string :semester
      t.integer :badgeset
      t.string :theme
      t.integer :coursegradescheme

      t.timestamps
    end
  end
end
