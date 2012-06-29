class Course < ActiveRecord::Base
  attr_accessible :badgeset, :coursegradescheme, :courseno, :name, :semester, :theme, :year, :badges
  
  has_many :users
  has_many :assignments, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :badge_sets
  
end
