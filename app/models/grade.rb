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
  
  Levels = ['Semifinalist','Finalist','Complete']

  def complete?
    level == 'Complete'
  end

  def semifinalist?
    level == 'Semifinalist'
  end

  def finalist?
    level == 'Finalist'
  end

  def rr_score
    if complete?
      5000
    elsif semifinalist?
      3000
    elsif finalist?
      2000
    else
      0
    end
  end
  
  def short?
    !substantial?
  end

  def blogscore
    if substantial?
      5000
    else
      1000
    end
  end

end
