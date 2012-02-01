class CreateGradeSchemes < ActiveRecord::Migration
  def change
    create_table :grade_schemes do |t|
      t.integer :assignment_id
      t.integer :ascore
      t.integer :amscore
      t.integer :bpscore
      t.integer :bscore
      t.integer :bmscore
      t.integer :cpscore
      t.integer :cscore
      t.integer :cmscore
      t.integer :dpscore
      t.integer :dscore
      t.integer :dmscore

      t.timestamps
    end
  end
end
