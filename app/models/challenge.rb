class Challenge < ActiveRecord::Base
  has_many :challenge_grades, :dependent => :destroy
  
  default_scope :order => 'date ASC'
end
