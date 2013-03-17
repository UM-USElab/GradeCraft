class AssignmentSubmission < ActiveRecord::Base
  attr_accessible :assignment_id, :comment, :feedback, :group_id, :attachment, :link, :submittable_id, :submittable_type, :text_feedback, :text_comment
  
  include Canable::Ables 
  #userstamps! # adds creator and updater 
  
  
  #has_attached_file :attachment
  
  belongs_to :submittable, :polymorphic => :true
  belongs_to :assignment
  has_one :grade
  accepts_nested_attributes_for :grade
  
  scope :ungraded
  
  validates_presence_of :assignment_id, :submittable_id, :submittable_type
  
  
  scope :for_submittable, ->(submittable) { where(:submittable_id => submittable.id, :submittable_type => submittable.class) }
  
  #Canable permissions
  def updatable_by?(user)
    if assignment.is_individual?
      submittable_id == user.id 
    elsif assignment.has_teams?
      submittable_id == user.teams.first.id 
    elsif assignment.has_groups?
      submittable_id == user.groups.first.id 
    end
  end
  
  def destroyable_by?(user)
    if assignment.is_individual?
      submittable_id == user.id 
    elsif assignment.has_teams?
      submittable_id == user.teams.first.id 
    elsif assignment.has_groups?
      submittable_id == user.groups.first.id 
    end
  end
  
  def viewable_by?(user)
    if assignment.is_individual?
      submittable_id == user.id 
    elsif assignment.has_teams?
      submittable_id == user.teams.first.id 
    elsif assignment.has_groups?
      submittable_id == user.groups.first.id 
    end
  end
  
  #Grading status
  def status
    if grade
      "Graded"
    else
      "Ungraded"
    end
  end
  
  def ungraded
    status == "Ungraded"
  end
  
end
