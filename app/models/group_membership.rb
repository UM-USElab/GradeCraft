class GroupMembership < ActiveRecord::Base
  attr_accessible :accepted, :group_id, :user_id
  
  belongs_to :user
  belongs_to :group
  
  validates_presence_of :group_id, :user_id
    
end
