class Challenge < ActiveRecord::Base
  has_many :challenge_grades, :dependent => :destroy
  belongs_to :courses
  
  attr_accessible :title, :points, :description, :date, :created_at, :updated_at, :type

  default_scope :order => 'date ASC'
end
