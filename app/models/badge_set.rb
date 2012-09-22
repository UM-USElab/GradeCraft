class BadgeSet < ActiveRecord::Base
  attr_accessible :name, :notes, :courses
  
  has_many :badges
  has_and_belongs_to_many :courses, :join_table => :course_badge_sets
  
  validates_presence_of :name

end
