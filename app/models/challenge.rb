class Challenge < ActiveRecord::Base
  has_many :challenge_grades, :dependent => :destroy
  
  attr_accessible :title, :points, :description, :date, :created_at, :updated_at, :type

  default_scope :order => 'date ASC'
end
