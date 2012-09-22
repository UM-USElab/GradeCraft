class EarnedBadge < ActiveRecord::Base

  belongs_to :earnable, :polymorphic => true
  
  belongs_to :badge
  
  attr_accessible :earnable, :badge, :badge_id, :created_at, :updated_at, :feedback, :earnable_id, :earnable_type, :earned
  attr_accessor :earned

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

