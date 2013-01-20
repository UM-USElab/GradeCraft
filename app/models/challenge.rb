class Challenge < ActiveRecord::Base
  attr_accessible :course_id, :description, :due_date, :has_challenge_submissions, :name, :point_total, :points_predictor_display, :release_necessary, :visible
end
