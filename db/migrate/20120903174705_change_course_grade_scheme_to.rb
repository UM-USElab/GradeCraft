class ChangeCourseGradeSchemeTo < ActiveRecord::Migration
  def change 
    rename_column :courses, :coursegradescheme, :grade_scheme_id
    drop_table :course_grade_schemes
  end
end
