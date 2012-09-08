class AssignmentSubmission < ActiveRecord::Base
  attr_accessible :assignment_id, :comment, :feedback, :group_id, :user_id, :attachment, :link
  
  #has_attached_file :attachment
  
  belongs_to :user
  belongs_to :assignment
  
end
