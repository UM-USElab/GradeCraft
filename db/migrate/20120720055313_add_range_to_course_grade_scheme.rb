class AddRangeToCourseGradeScheme < ActiveRecord::Migration
  def change
    add_column :course_grade_schemes, :low_range, :integer
    add_column :course_grade_schemes, :high_range, :integer
    add_column :course_grade_schemes, :letter_grade, :string
  end
end
