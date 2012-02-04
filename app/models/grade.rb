class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :earned_badges
  has_many :badges, :through => :earned_badges

  validates_presence_of :user
  validates_presence_of :assignment
  
  delegate :title, :description, :point_total, :to => :assignment
  
  after_save :save_user_score
  
  scope :reading_reactions, where(:type => "ReadingReactionGrade")
  
  def score
    super || 0
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
  
  def save_user_score
    user.save
  end

end
