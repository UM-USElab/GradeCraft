class Grade < ActiveRecord::Base
  self.inheritance_column = 'something_you_will_not_use'
    
  include Canable::Ables 
  #userstamps! # adds creator and updater
  
  belongs_to :gradeable, :polymorphic => :true
  belongs_to :assignment
  belongs_to :assignment_submission
  has_many :grade_scheme_elements, :through => :assignment
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  
  validates_uniqueness_of :gradeable_id, :scope => :assignment_id
  
  accepts_nested_attributes_for :earned_badges, :reject_if => Proc.new { |earned_badge_attrs| earned_badge_attrs[:earned] != '1' }

  attr_accessible :type, :raw_score, :final_score, :feedback, :assignment_id, :badge_id, :created_at, :updated_at, :complete, :semis, :finals, :status, :attempted, :substantial, :user, :badge_ids, :grade, :gradeable, :gradeable_id, :gradeable_type, :earned_badges_attributes, :earned, :assignment_submission_id

  validates_presence_of :gradeable_id, :assignment_id
  
  delegate :name, :description, :due_date, :to => :assignment
  
  after_save :save_gradeable_score
  after_destroy :save_gradeable_score
  
  scope :completion, :joins => :assignment, :order => "assignments.due_date ASC"
  scope :for_gradeable, ->(gradeable) { where(:gradeable_id => gradeable.id, :gradeable_type => gradeable.class) }

  def raw_score
    super || 0
  end
  
  def score(student)
    if final_score?
      final_score
    else 
      raw_score * multiplier(student)
    end
  end
  
  def unmultiplied_score
    if final_score?
      final_score
    else 
      raw_score
    end
  end
  
  def point_total(student)
    assignment.point_total * multiplier(student)
  end
  
  def multiplier(student)
    assignment.multiplier_for_student(student)
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
  
  #Canable Permissions
  def updatable_by?(user)
    creator == user
  end
  
  def creatable_by?(user)
    gradeable_id = user.id
  end
  
  def viewable_by?(user)
    gradeable_id == user.id 
  end

  def self.to_csv(options = {})
    #CSV.generate(options) do |csv|
      #csv << ["First Name", "Last Name", "Score", "Grade"]
      #students.each do |user|
        #csv << [user.first_name, user.last_name]
        #, user.earned_grades(course), user.grade_level(course)]
      #end
    #end
  end

end
