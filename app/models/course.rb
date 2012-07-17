class Course < ActiveRecord::Base
  attr_accessible :badge_sets_id, :coursegradescheme, :courseno, :name, :semester, :theme_id, :year, :badge_setting, :team_setting, :team_term, :user_term, :user_id, :course_id, :homepage_message, :group_setting
  
  has_many :course_memberships, :dependent => :destroy
  has_many :users, :through => :course_memberships
  accepts_nested_attributes_for :users
  
  has_many :assignments, :dependent => :destroy
  has_many :assignment_types, :dependent => :destroy
  belongs_to :badge_set
  has_many :badges, :through => :badge_set
  has_many :challenges, :dependent => :destroy
  has_many :course_grade_scheme, :dependent => :destroy
  has_many :grades, :through => :assignments
  has_many :groups, :dependent => :destroy
  has_many :news, :dependent => :destroy
  has_many :teams, :dependent => :destroy
  has_many :team_assignments, :dependent => :destroy
  belongs_to :theme
  
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
  
  def has_teams?
    team_setting == true
  end
  
  def has_badges?
    badge_setting == true
  end
  
  def has_groups?
    group_setting == true
  end
  
end
