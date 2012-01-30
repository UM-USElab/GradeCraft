class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :earned_badges
  has_many :badges, :through => :earned_badges

  validates_presence_of :user
  validates_presence_of :assignment
  
  after_save :save_user_score

  def score
    super || 0
  end
  
  Levels = ['Semifinalist','Finalist','Complete']
  
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
  
  def save_user_score
    user.save;
  end

end
