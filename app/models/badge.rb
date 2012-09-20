class Badge < ActiveRecord::Base
  attr_accessible :assignment_id, :name, :description, :icon, :visible, :created_at, :updated_at, :image_file_name, :occurrence, :badge_set_id, :value, :multiplier

  #has_attached_file :image, :styles => { :small => "70x70>" }
  
  #mount_uploader :icon, ImageUploader
  has_many :earned_badges, :dependent => :destroy
  belongs_to :badge_set
  
  accepts_nested_attributes_for :badge_set
  
  validates_presence_of :name
  
  default_scope :order => 'id ASC'
  
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
  
end
