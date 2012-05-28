class Group < ActiveRecord::Base
  has_many :users
  has_many :badges
  
  attr_accessible :name, :created_at, :updated_at
  
end
