class AddValueToGradeSchemeElement < ActiveRecord::Migration
  def change
    remove_column :grade_scheme_elements, :low_range
    rename_column :grade_scheme_elements, :high_range, :value
    add_column :grades, :final_score, :integer
    rename_column :grades, :score, :raw_score
  end
end
