class AssignmentSubmission < ActiveRecord::Base
  attr_accessible :assignment_id, :comment, :feedback, :group_id, :user_id, :attachment, :link
  
  include Canable::Ables  
  
  def updatable_by?(user)
    creator == user
  end
  
  def destroyable_by?(user)
    updatable_by?(user)
  end
  
  #has_attached_file :attachment
  
  belongs_to :user
  belongs_to :assignment
  
  validates_presence_of :assignment_id, :user_id
  
end
