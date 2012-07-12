class CreateCourseGradeSchemes < ActiveRecord::Migration
  def change
    create_table :course_grade_schemes do |t|
      t.string :name

      t.timestamps
    end
  end
end
