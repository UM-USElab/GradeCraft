class BadgeSet < ActiveRecord::Base
  attr_accessible :name, :notes
  
  has_many :badges, :dependent => :destroy
end
