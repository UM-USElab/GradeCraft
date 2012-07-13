class Group < ActiveRecord::Base
  has_many :users
  has_many :badges
  
  belongs_to :course
  
  attr_accessible :name, :created_at, :updated_at
  
end
