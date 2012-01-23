class Assignment < ActiveRecord::Base
  has_many :grades
  accepts_nested_attributes_for :grades
end
