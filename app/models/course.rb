class Course < ActiveRecord::Base
  attr_accessible :badge_sets_id, :coursegradescheme, :courseno, :name, :semester, :theme_id, :year, :badge_setting, :team_setting, :team_term, :user_term, :user_id, :course_id, :homepage_message, :group_setting, :user_weight_amount, :user_weight_amount_close_date
  
  has_and_belongs_to_many :users, :join_table => :course_memberships
  accepts_nested_attributes_for :users
  
  has_many :assignments, :dependent => :destroy
  has_many :assignment_types, :dependent => :destroy
  has_and_belongs_to_many :badge_sets
  has_many :badges, :through => :badge_set
  has_many :earned_badges, :through => :users
  has_many :course_grade_schemes, :dependent => :destroy
  has_many :grade_schemes
  has_many :grades, :through => :assignments
  has_many :groups, :dependent => :destroy
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
