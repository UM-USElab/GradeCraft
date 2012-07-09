class Challenge < ActiveRecord::Base
  set_inheritance_column 'something_you_will_not_use'
  has_many :challenge_grades, :dependent => :destroy
  belongs_to :course
  
  attr_accessible :title, :points, :description, :date, :created_at, :updated_at, :type

  default_scope :order => 'date ASC'
end
