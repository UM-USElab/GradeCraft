class AddRangeToGradeSchemeElements < ActiveRecord::Migration
  def change
    add_column :grade_scheme_elements, :high_range, :integer
    rename_column :grade_scheme_elements, :value, :low_range
  end
end
