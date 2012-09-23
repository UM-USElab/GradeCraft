class CriteriaLevel < ActiveRecord::Base
  attr_accessible :criteria_id, :description, :name, :value
  
  belongs_to :criterium
  belongs_to :rubric
  belongs_to :assignment
end
