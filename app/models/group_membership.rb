class GroupMembership < ActiveRecord::Base
  attr_accessible :accepted, :group_id, :user_id, :assignment_id
  
  belongs_to :user
  belongs_to :assignment
  belongs_to :group
  
  validates_presence_of :assignment_id, :group_id, :user_id
    
end
