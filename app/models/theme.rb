class Theme < ActiveRecord::Base
  attr_accessible :filename, :name
  
  has_many :courses
  
end
