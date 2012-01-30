class Assignment < ActiveRecord::Base
  has_many :grades
  accepts_nested_attributes_for :grades
  
  attr_accessible :title, :description, :point_total, :type, :due_date

  def mass_gradeable?
    true
  end

end
