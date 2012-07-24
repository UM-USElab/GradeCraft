class AddGradeSchemeToGse < ActiveRecord::Migration
  def change
    add_column :grade_scheme_elements, :grade_scheme_id, :integer
  end
end
