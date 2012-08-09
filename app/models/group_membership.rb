class GroupMembership < ActiveRecord::Base
  attr_accessible :accepted, :group_id, :user_id
end
