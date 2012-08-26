class Grade < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
    
  belongs_to :gradeable, :polymorphic => :true
  belongs_to :assignment
  has_many :grade_scheme_elements, :through => :assignment
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  
  accepts_nested_attributes_for :earned_badges
  attr_accessible :type, :raw_score, :final_score, :feedback, :user_id, :assignment_id, :badge_id, :created_at, :updated_at, :complete, :semis, :finals, :status, :attempted, :substantial, :user, :badge_ids, :grade, :gradeable, :gradeable_id, :gradeable_type

  validates_presence_of :gradeable
  validates_presence_of :assignment
  
  delegate :title, :description, :point_total, :due_date, :to => :assignment
  
  after_save :save_user_score
  after_destroy :save_user_score
  
  scope :completion, :joins => :assignment, :order => "assignments.due_date ASC"

  def raw_score
    super || 0
  end
  
  def score
    if final_score?
      final_score
    else 
      raw_score
    end
  end
  
  def attempted?
    raw_score > 0
  end
  
  def has_feedback?
    feedback != nil
  end
  
  def save_user_score
    gradeable.save
  end
  
  def is_released?
    status == "Released"
  end
  
  def points_possible
    assignment.point_total
  end
 
  def assignment_type
    #assignment.assignment_type
  end 

end
