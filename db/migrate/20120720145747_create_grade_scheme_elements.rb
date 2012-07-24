class CreateGradeSchemeElements < ActiveRecord::Migration
  def change
    create_table :grade_scheme_elements do |t|
      t.string :name
      t.integer :low_range
      t.integer :high_range
      t.string :letter_grade

      t.timestamps
    end
  end
end
