class ChangeGradeSchemes < ActiveRecord::Migration
  def up
    remove_column :grade_schemes, :apscore
    remove_column :grade_schemes, :ascore
    remove_column :grade_schemes, :amscore
    remove_column :grade_schemes, :bpscore
    remove_column :grade_schemes, :bscore
    remove_column :grade_schemes, :bmscore
    remove_column :grade_schemes, :cpscore
    remove_column :grade_schemes, :dpscore
    remove_column :grade_schemes, :dscore
    remove_column :grade_schemes, :dmscore
  end

  def down
    add_column :grade_schemes, :apscore
    add_column :grade_schemes, :ascore
    add_column :grade_schemes, :amscore
    add_column :grade_schemes, :bpscore
    add_column :grade_schemes, :bscore
    add_column :grade_schemes, :bmscore
    add_column :grade_schemes, :cpscore
    add_column :grade_schemes, :dpscore
    add_column :grade_schemes, :dscore
    add_column :grade_schemes, :dmscore
  end
end
