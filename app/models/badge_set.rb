class BadgeSet < ActiveRecord::Base
  attr_accessible :name, :notes
  
  has_many :badges
  has_many :courses

end
