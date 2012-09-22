class Theme < ActiveRecord::Base
  attr_accessible :filename, :name
  
  has_many :courses
  
  validates_presence_of :filename, :name
  
  #mount_uploader :filename, ImageUploader
  
end
