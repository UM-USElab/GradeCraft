class InfoController < ApplicationController

  respond_to :html

  helper_method :sort_column, :sort_direction
  
  before_filter :require_login, :except => [:show, :using_gradecraft]


  def dashboard
    if current_user.is_gsi?
      @teams = current_user.teams
      @students = current_course.users.students
      #@top_ten_students = @students.order('course_memberships.sortable_score DESC').limit(10)
      #@bottom_ten_students = @students.order('course_memberships.sortable_score ASC').limit(10)
      @top_ten_students = @students.limit(10)
      @bottom_ten_students = @students.limit(10)
    elsif current_user.is_prof?
      @teams = current_course.teams.all
      @students = current_course.users.students
      #@top_ten_students = @students.order('course_memberships.sortable_score DESC').limit(10)
      #@bottom_ten_students = @students.order('course_memberships.sortable_score ASC').limit(10)
      @top_ten_students = @students.limit(10)
      @bottom_ten_students = @students.limit(10)
    elsif current_user.is_admin?
      @teams = current_course.teams.all
      @students = current_course.users.students
      #@top_ten_students = @students.order('course_memberships.sortable_score DESC').limit(10)
      #@bottom_ten_students = @students.order('course_memberships.sortable_score ASC').limit(10)
      @top_ten_students = @students.limit(10)
      @bottom_ten_students = @students.limit(10)
    end
    @badges = current_course.badges
    @user = current_user# 
    @assignments = current_course.assignments
    @submissions = current_course.assignment_submissions
    @assignment_types = current_course.try(:assignment_types)
  end
  # 
#   def cosign_test
#     render :text => request.env["REMOTE_USER"]
#   end


end
