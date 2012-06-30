class EarnedBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :grade
  belongs_to :team
  
  attr_accessible :grade_id, :badge_id, :created_at, :updated_at

  delegate :title, :description, :icon, :to => :badge

end

