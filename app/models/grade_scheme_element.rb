class GradeSchemeElement < ActiveRecord::Base
  attr_accessible :high_range, :letter_grade, :low_range, :name
  
  belongs_to :grade_scheme
end
