class AssignmentSubmission < ActiveRecord::Base
  attr_accessible :assignment_id, :comment, :feedback, :group_id, :user_id, :attachment
  
  has_attached_file :attachment
  
end
