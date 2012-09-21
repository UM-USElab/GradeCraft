class GradeScheme < ActiveRecord::Base
  has_many :assignments
  belongs_to :courses
  has_many :grade_scheme_elements
  
  attr_accessible :created_at, :updated_at, :name, :course_id
  
  validates_presence_of :name, :course_id

  def element_names
    @names ||= {}.tap do |names|
      grade_scheme_elements.each do |element|
        names[[element.low_range,element.high_range]] = element.element_name
      end
    end
  end
  
  def grade_level(score)
    element_names.each do |range,name|
      return name if score.between?(*range)
    end
    nil
  end
  
end
