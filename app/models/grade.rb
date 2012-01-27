class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :earned_badges
  has_many :badges, :through => :earned_badges

  attr_accessible :feedback, :score, :user_id, :assignment_id, :badge_ids

  validates_presence_of :user
  validates_presence_of :assignment

  def score
    super || 0
  end

end
