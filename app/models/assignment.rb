class Assignment < ActiveRecord::Base
  has_many :grades
  has_many :badges
end
