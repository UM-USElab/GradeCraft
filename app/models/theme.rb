class Theme < ActiveRecord::Base
  attr_accessible :filename, :name
  
  belongs_to :course
  
end
