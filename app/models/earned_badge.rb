class EarnedBadge < ActiveRecord::Base

  belongs_to :badge
  belongs_to :grade

  delegate :title, :description, :icon, :to => :badge

end

