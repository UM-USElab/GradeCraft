class User < ActiveRecord::Base
  authenticates_with_sorcery!

  Roles = %w{student professor gsi admin}
  
  attr_accessor :remember_me
  attr_accessible :username, :email, :crypted_password, :remember_me_token, :avatar_file_name, :role, :team_id, :first_name, :last_name, :sortable_score, :rank, :course_ids, :user_id, :display_name, :private_display, :default_course_id

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>",
                                 :thumb => "100x100>" },
                    :url => '/assets/avatars/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/assets/avatars/:id/:style/:basename.:extension',
                    :default_url => '/images/missing_:style.png'
  
  has_many :course_memberships, :dependent => :destroy
  has_many :courses, :through => :course_memberships
  accepts_nested_attributes_for :courses
            
  has_many :grades, :dependent => :destroy
  has_many :earned_badges, :through => :grades
  belongs_to :team
  has_many :group_memberships, :dependent => :destroy
  has_many :groups, :through => :group_memberships

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates :username, :presence => true,
                    :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  %w{student gsi professor admin}.each do |role|
    scope role.pluralize, where(:role => role)
  end 
  
  def name
    [first_name,last_name].join(' ')
  end
  
  def public_name
    if display_name?
      display_name
    else 
      email
    end
  end

  def is_prof?
    role == "professor"
  end

  def is_gsi?
    role == "gsi"
  end

  def is_student?
    role == "student" || role.blank?
  end

  def is_admin?
    role == "admin"
  end

  def role
    super || "student"
  end

  def is_staff?
    is_prof? || is_gsi? || is_admin?
  end

 #  #Actual
#   def boss_battle_score
#     grades.bossbattle.sum(:score) || 0
#   end
#   
#   def team_assignment_score
#     grades.team_assignment.sum(:score) || 0
#   end
#    
#   def lfpg_score
#     grades.lfpg.sum(:score) || 0
#   end
#   
#   def blogging_score
#     grades.blogging.map(&:score).inject(&:+) || 0
#   end
#   
#   def attendance_score
#     grades.attendance.sum(:score) || 0
#   end
#   
#   def reading_reaction_score
#     grades.reading_reaction.map(&:score).inject(&:+) || 0
#   end
   
  def score
    grades.map(&:score).inject(&:+) || 0
  end
  
  def sortable_score
    
  end
  
  def rank
    
  end
  
  def find_scoped_courses(course_id)
    course_id = BSON::ObjectId(course_id) if course_id.is_a?(String)
    if is_admin? || self.course_ids.include?(course_id)
      Course.find(course_id)
    else
      raise 
    end
  end
  
def default_course
  @default_course ||= (self.courses.where(:id => self.default_course_id).first || self.courses.first)
end

  # #Possible 
#   def reading_reaction_possible
#     grades.where(:type=>"ReadingReactionGrade").map(&:points_possible).inject(&:+) || 0
#   end
#     
#   def lfpg_possible
#     grades.where(:type=>"LFPGGrade").map(&:points_possible).inject(&:+) || 0
#   end
#     
#   def boss_battle_possible
#     grades.where(:type=>"BossBattleGrade").map(&:points_possible).inject(&:+) || 0
#   end
#   
#   def attendance_possible
#     grades.where(:type=>"AttendanceGrade").map(&:points_possible).inject(&:+) || 0
#   end
#   
#   def team_assignment_possible
#     grades.where(:type=>"TeamAssignmentGrade").map(&:points_possible).inject(&:+) || 0
#   end
#   
#   def possible_score
#     attendance_possible + reading_reaction_possible + boss_battle_possible + lfpg_possible + blogging_score + team_assignment_possible || 0
#   end
  
end
