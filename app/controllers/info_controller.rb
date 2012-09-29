class InfoController < ApplicationController

  respond_to :html

  helper_method :sort_column, :sort_direction

  def dashboard
    @title = "My Dashboard"
    @teams = current_course.teams.all
    if current_user.is_gsi?
      @teams = current_user.teams.all
      @students = @teams.users.students
    elsif current_user.is_professor?
      @students = current_course.users.students
    end
    @badges = current_course.badges
    @user = current_user# 
     @top_ten_students = @students.order('sortable_score DESC').limit(10)
    @bottom_ten_students = @students.order('sortable_score ASC').limit(10)
    @assignments = current_course.assignments
    @submissions = current_course.assignment_submissions
    @assignment_types = current_course.try(:assignment_types)
  end
  # 
#   def cosign_test
#     render :text => request.env["REMOTE_USER"]
#   end


end
