class GradeScheme < ActiveRecord::Base
  has_many :assignments
  has_many :courses
  has_many :grade_scheme_elements
  
  attr_accessible :created_at, :updated_at, :name, :course_id
  
  def grade_level(raw_score)
    element_names.each do |range,name|
      return name if raw_score.between?(*range)
    end
  end

  def elements_names
    @names ||= {}.tap do |names|
      grade_scheme_elements.each do |element|
        names[[element.low_range,element.high_range]] = element.element_name
      end
    end
  end
  
end
