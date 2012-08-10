class AddDescriptionToGradeSchemeElement < ActiveRecord::Migration
  def change
    add_column :grade_scheme_elements, :description, :string
  end
end
