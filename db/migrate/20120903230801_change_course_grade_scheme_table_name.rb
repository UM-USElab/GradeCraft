class ChangeCourseGradeSchemeTableName < ActiveRecord::Migration
  def change 
    rename_table :course_grade_scheme, :course_grade_schemes
  end

  def down
  end
end
