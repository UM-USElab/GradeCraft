class UserAssignmentTypeWeight < ActiveRecord::Base
  attr_accessible :user_id, :assignment_type_id, :value
  
  belongs_to :user
  belongs_to :assignment_type
  
  validates_presence_of :user_id, :assignment_type_id, :value
end
