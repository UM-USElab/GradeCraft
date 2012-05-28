class Badge < ActiveRecord::Base
  
  attr_accessible :assignment_id, :title, :description, :icon, :visible, :created_at, :updated_at, :image_file_name, :image_content_type, :occurrence

  has_attached_file :image, :styles => { :small => "70x70>" }
  has_many :earned_badges, :dependent => :destroy
  
  default_scope :order => 'id ASC'
  
  def occurance
    super || "onetime"
  end
  
end
