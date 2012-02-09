class Challenge < ActiveRecord::Base
  has_many :challenge_grades, :dependent => :destroy
end
