class EarnedBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :grade
  belongs_to :user
  
  attr_accessible :grade_id, :badge_id, :created_at, :updated_at, :feedback, :user_id

  delegate :title, :description, :icon, :to => :badge

end

