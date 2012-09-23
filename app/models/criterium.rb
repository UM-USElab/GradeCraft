class Criterium < ActiveRecord::Base
  attr_accessible :description, :name, :ruberic_id
  
  belongs_to :rubric
  has_many :criteria_levels
end
