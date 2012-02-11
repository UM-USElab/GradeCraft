class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :earned_badges, :dependent => :destroy
  has_many :badges, :through => :earned_badges

  validates_presence_of :user
  validates_presence_of :assignment
  
  delegate :title, :description, :point_total, :due_date, :to => :assignment
  
  after_save :save_user_score
  
  #default_scope :order => 'due_date ASC'
  
  scope :reading_reaction, where(:type => "ReadingReactionGrade")
  scope :standard, where(:type=> "StandardGrade")
  scope :blogging, where(:type=> "BloggingGrade")
  scope :attendance, where(:type=> "AttendanceGrade")
  
  scope :isreleased, where(:released=> 1)
  
  Assignments = @assignments
  
  def score
    super || 0
  end
  
  def attempted?
    score > 0
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
  
  def is_released?
    released == 1 || role.blank?
  end
  
  def points_possible
    assignment.point_total
  end

end
