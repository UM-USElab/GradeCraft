class TeamMembership < ActiveRecord::Base
  attr_accessible :team_id, :user_id
  
  belongs_to :user
  belongs_to :team
  
  validates_presence_of :team_id, :user_id
    
end
