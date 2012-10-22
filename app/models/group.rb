class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :users, :through => :group_memberships, :uniq => true 
  has_many :grades, :as => :gradeable, :dependent => :destroy
  
  belongs_to :course
  belongs_to :assignment
  validates_presence_of :assignment_id, :name
  validate :course_max_value_of_groups_not_exceeded
  
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  has_many :assignment_submissions, :as => :submittable, :dependent => :destroy
    
  attr_accessible :name, :created_at, :updated_at, :proposal, :approved, :assignment_id, :user_ids, :text_proposal
  
  
  def group_members_count
    self.group_memberships.count 
  end
  
  #TODO fix
  def course_max_value_of_groups_not_exceeded
    group_members_count <= 6
  end
  
  def grades_by_assignment_id
    @grades_by_assignment ||= grades.group_by(&:assignment_id)
  end
  
  def grade_for_assignment(assignment)
    grades_by_assignment_id[assignment.id].try(:first)
  end
  
end
