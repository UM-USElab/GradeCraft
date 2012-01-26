class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :earned_badges
  has_many :badges, :through => :earned_badges
  
  attr_accessible :feedback, :score, :user_id, :assignment_id, :badge_id
  
  validates :user_id, :presence => true
  validates :score, :presence => true
  validates :assignment_id, :presence => true
end
