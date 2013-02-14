class Badge < ActiveRecord::Base
  attr_accessible :assignment_id, :name, :description, :icon, :visible, :created_at, :updated_at, :image_file_name, :occurrence, :badge_set_id, :value, :multiplier

  #has_attached_file :image, :styles => { :small => "70x70>" }
  
  #mount_uploader :icon, ImageUploader
  has_many :earned_badges, :dependent => :destroy
  has_many :elements, :dependent => :destroy
  belongs_to :badge_set
  belongs_to :course
  belongs_to :assignment
  
  accepts_nested_attributes_for :badge_set
  
  validates_presence_of :name
  
  default_scope :order => 'badges.id ASC'
  
  def occurance
    super || "onetime"
  end
  
  def point_value 
    if value
      value 
    else
      0
    end
  end
  
  def badges_earned
    EarnedBadge.where(:badge_id => id)
  end
  
  def visible? 
    visible == "1"
  end
  
  #badges per role  
  def earned_badges_by_earnable_id
    @earned_badges_by_earnable_id ||= earned_badges.group_by { |eb| [eb.earnable_type,eb.earnable_id] }
  end
  
  def earned_badge_for_student(student)
    earned_badges_by_earnable_id[['User',student.id]].try(:first)
  end 
  
end
