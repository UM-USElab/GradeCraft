class Group < ActiveRecord::Base
  has_many :users
  has_many :badges
  
  belongs_to :course
  validates_presence_of :course
  belongs_to :assignment
  validates_presence_of :assignment
    
  attr_accessible :name, :created_at, :updated_at, :proposal, :approved, :assignment_id
  
end
