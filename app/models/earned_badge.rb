class EarnedBadge < ActiveRecord::Base

  belongs_to :earnable, :polymorphic => true
  
  belongs_to :badge
  
  attr_accessible :grade_id, :badge_id, :created_at, :updated_at, :feedback, :earnable_id, :earnable_type

  delegate :name, :description, :icon, :to => :badge

end

