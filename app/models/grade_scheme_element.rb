class GradeSchemeElement < ActiveRecord::Base
  attr_accessible :letter_grade, :low_range, :high_range, :name, :grade_scheme_id
  
  belongs_to :grade_scheme

  def element_name
    if name?
      name
    else 
      letter_grade
    end
  end

end
