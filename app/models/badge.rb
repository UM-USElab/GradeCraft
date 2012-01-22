class Badge < ActiveRecord::Base
  has_attached_file :image, :styles => { :small => "70x70>" }
end
