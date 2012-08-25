class GradeSchemeElement < ActiveRecord::Base
  attr_accessible :letter_grade, :value, :name, :grade_scheme_id
  
  belongs_to :grade_scheme

end
