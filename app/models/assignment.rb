class Assignment < ActiveRecord::Base
  has_many :grades, :dependent => :destroy
  accepts_nested_attributes_for :grades
  
  default_scope :order => 'due_date ASC'

  #attr_accessible :type, :title, :description, :due_date, :point_total

  def mass_gradeable?
    true
  end
  
  scope :reading_reactions, where(:type => "ReadingReaction")
  scope :standard, where(:type=> "Standard")
  scope :blogging, where(:type=> "Blogging")
  scope :attendance, where(:type=> "Attendance")

end