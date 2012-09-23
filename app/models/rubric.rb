class Rubric < ActiveRecord::Base
  attr_accessible :assignment_id, :description, :name
  
  belongs_to :assignment
  has_many :criteria
  has_many :criteria_levels, :through => :criteria
end
