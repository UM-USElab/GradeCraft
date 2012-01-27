class Assignment < ActiveRecord::Base
  has_many :grades
  accepts_nested_attributes_for :grades

  scope :one_time, where(:type => nil)

  def mass_gradeable?
    true
  end

end
