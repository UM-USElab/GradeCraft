class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :users, :through => :group_memberships
  has_many :grades, :as => :gradeable, :dependent => :destroy
  
  belongs_to :course
  belongs_to :assignment
  validates_presence_of :assignment, :course, :name
  
  has_many :earned_badges, :as => :earnable, :dependent => :destroy
  has_many :badges, :through => :earned_badges
  has_many :assignment_submissions, :as => :submittable, :dependent => :destroy
    
  attr_accessible :name, :created_at, :updated_at, :proposal, :approved, :assignment_id, :user_ids
  
end
