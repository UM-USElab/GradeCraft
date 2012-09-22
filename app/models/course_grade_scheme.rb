class CourseGradeScheme < ActiveRecord::Base
   has_many :courses
   has_many :course_grade_scheme_elements

   attr_accessible :created_at, :updated_at, :name, :course_id
   
   validates_presence_of :name

  def element_names
    @names ||= {}.tap do |names|
      course_grade_scheme_elements.each do |element|
        names[[element.low_range,element.high_range]] = element.element_name
      end
    end
  end
  
  def grade_level(sortable_score)
    element_names.each do |range,name|
      return name if sortable_score.between?(*range)
    end
    nil
  end
end
