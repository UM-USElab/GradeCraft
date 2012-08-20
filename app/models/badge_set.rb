class BadgeSet < ActiveRecord::Base
  attr_accessible :name, :notes
  
  has_many :badges
  has_and_belongs_to_many :courses

end
