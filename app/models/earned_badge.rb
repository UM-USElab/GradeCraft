class EarnedBadge < ActiveRecord::Base

  belongs_to :earnable, :polymorphic => true
  
  belongs_to :badge
  
  attr_accessible :earnable, :badge, :badge_id, :created_at, :updated_at, :feedback, :earnable_id, :earnable_type
  attr_accessor :earned

  delegate :name, :description, :icon, :value, :to => :badge
  
  def point_value 
    if value
      value 
    else
      0
    end
  end

end

