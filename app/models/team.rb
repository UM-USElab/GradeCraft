class Team < ActiveRecord::Base
  has_many :users
  has_many :challenge_grades, :dependent => :destroy
  has_many :earned_badges, :through => :users
  
  attr_accessible :name, :created_at, :updated_at, :banner_file_name, :banner_updated_at, :sortable_score, :rank

  default_scope :order => 'id ASC'

  def user_grades
    Grade.where(:user_id => users)
  end

  def score
    challenge_grade + reading_reaction_score
  end

  def challenge_grade
    challenge_grades.map(&:score).inject(&:+) || 0
  end

  def reading_reaction_score
    500 * user_grades.reading_reaction.where(:semis => true).count || 0
  end

end
