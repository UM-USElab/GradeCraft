class BadgeSet < ActiveRecord::Base
  attr_accessible :name, :notes
  
  has_many :badges
  belongs_to :course

end
