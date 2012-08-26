class Badge < ActiveRecord::Base
  attr_accessible :assignment_id, :name, :description, :icon, :visible, :created_at, :updated_at, :image_file_name, :occurrence, :badge_set_id, :value, :multiplier

  has_attached_file :image, :styles => { :small => "70x70>" }
  has_many :earned_badges, :dependent => :destroy
  belongs_to :badge_set
  belongs_to :course
  
  accepts_nested_attributes_for :badge_set
  
  default_scope :order => 'id ASC'
  
  def occurance
    super || "onetime"
  end
  
end
