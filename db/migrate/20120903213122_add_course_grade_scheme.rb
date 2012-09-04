class AddCourseGradeScheme < ActiveRecord::Migration
  def up
    create_table :course_grade_scheme do |t|
      t.string :name
 
      t.timestamps
    end
    
    create_table :course_grade_scheme_elements do |t|
      t.string :name
      t.string :letter_grade
      t.integer :low_range
      t.integer :high_range
      t.integer :course_grade_scheme_id
      
      t.timestamps
    end

    rename_column :courses, :grade_scheme_id, :course_grade_scheme_id
  end
  
  def down 
    drop_table :course_grade_scheme
    
    drop_table :course_grade_scheme_elements
    
  end
end
