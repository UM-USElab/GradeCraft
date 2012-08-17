class GroupMembership < ActiveRecord::Base
  attr_accessible :accepted, :group_id, :user_id, :assignment_id
  
  belongs_to :user
  belongs_to :assignment
  
end
