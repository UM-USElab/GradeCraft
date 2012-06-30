class Course < ActiveRecord::Base
  attr_accessible :badge_sets_id, :coursegradescheme, :courseno, :name, :semester, :themes_id, :year, :badge_setting, :teams_setting
  
  has_many :assignments, :dependent => :destroy
  has_one :badge_sets
  has_many :challenges, :dependent => :destroy
  has_many :course_grade_scheme, :dependent => :destroy
  has_many :grades
  has_many :groups, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :team_assignments, :dependent => :destroy
  has_one :theme
  has_many :users
  
end
