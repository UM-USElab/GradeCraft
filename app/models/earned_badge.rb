class EarnedBadge < ActiveRecord::Base

  belongs_to :earnable, :polymorphic => true
  belongs_to :badge
  belongs_to :grade
  
  attr_accessible :earnable, :badge, :badge_id, :badge_ids, :feedback, :text_feedback, :earnable_id, :earnable_type, :earned, :earned_badges

  delegate :name, :description, :icon, :value, :to => :badge
  
  validates_presence_of :earnable_id, :badge_id
  
  def point_value 
    if value
      value 
    else
      0
    end
  end

end

