class UserAssignmentTypeWeight < ActiveRecord::Base
  attr_accessible :user_id, :assignment_id, :value
  
  belongs_to :user
  belongs_to :assignment_type
end
