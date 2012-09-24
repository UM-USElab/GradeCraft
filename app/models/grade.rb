class Grade < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
    
  belongs_to :gradeable, :polymorphic => :true
  belongs_to :assignment
  belongs_to :assignment_submission
  has_many :grade_scheme_elements, :through => :assignment
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  
  validates_uniqueness_of :gradeable_id, :scope => :assignment_id
  
  accepts_nested_attributes_for :earned_badges, :reject_if => Proc.new { |earned_badge_attrs| earned_badge_attrs[:earned] != '1' }

  attr_accessible :type, :raw_score, :final_score, :feedback, :assignment_id, :badge_id, :created_at, :updated_at, :complete, :semis, :finals, :status, :attempted, :substantial, :user, :badge_ids, :grade, :gradeable, :gradeable_id, :gradeable_type, :earned_badges_attributes, :earned

  validates_presence_of :gradeable_id, :assignment_id
  
  delegate :name, :description, :point_total, :due_date, :to => :assignment
  
  after_save :save_gradeable_score
  after_destroy :save_gradeable_score
  
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
    score > 0
  end
  
  def has_feedback?
    feedback != "" && feedback != nil 
  end
  
  def save_gradeable_score
    gradeable.save
  end
  
  def is_released?
    status == "Released"
  end
  
  def points_possible
    assignment.point_total
  end

end
