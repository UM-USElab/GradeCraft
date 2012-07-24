class GradeSchemeElement < ActiveRecord::Base
  attr_accessible :high_range, :letter_grade, :low_range, :name, :grade_scheme_id
  
  belongs_to :grade_scheme
end
