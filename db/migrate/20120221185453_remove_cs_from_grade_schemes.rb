class RemoveCsFromGradeSchemes < ActiveRecord::Migration
  def up
    remove_column :grade_schemes, :cscore
    remove_column :grade_schemes, :cmscore
  end

  def down
    add_column :grade_schemes, :cscore
    add_column :grade_schemes, :cmscore
  end
end
