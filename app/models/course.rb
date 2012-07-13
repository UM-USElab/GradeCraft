class Course < ActiveRecord::Base
  attr_accessible :badge_sets_id, :coursegradescheme, :courseno, :name, :semester, :themes_id, :year, :badge_setting, :team_setting, :team_term, :user_term, :user_id, :course_id, :homepage_message
  
  has_many :course_memberships, :dependent => :destroy
  has_many :users, :through => :course_memberships
  accepts_nested_attributes_for :users
  
  has_many :assignments, :dependent => :destroy
  has_many :badge_sets
  has_many :challenges, :dependent => :destroy
  has_many :course_grade_scheme, :dependent => :destroy
  has_many :grades
  has_many :groups, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :team_assignments, :dependent => :destroy
  has_many :themes
  
  def user_ref
    if user_term?
      user_term
    else 
      "Player"
    end
  end
  
  def team_ref
    if team_term?
      team_term
    else 
      "team"
    end
  end
  
end
