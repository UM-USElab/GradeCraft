class Group < ActiveRecord::Base
  has_many :users
  has_many :badges
  
  belongs_to :course
  validates_presence_of :course
  belongs_to :assignment
    
  attr_accessible :name, :created_at, :updated_at
  
end
