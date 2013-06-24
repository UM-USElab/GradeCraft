class HomeController < ApplicationController
    
 before_filter :require_login, :only => [:login, :register]
  
  def index 
    if current_user
      if current_user.is_admin?
        @title = "Course Dashboard"
      else
        @user = current_user
        @user_assignment_type_weights = @user.user_assignment_type_weights.all
        @user_assignment_type_weight = @user.user_assignment_type_weights.new
        @assignment_types = current_course.assignment_types
        #@assignment_type_choice = current_course.assignment_types.student_choice
      end
      @teams = current_course.try(:teams)
      @users = current_course.try(:users)
      @badges = current_course.badges
      @students = current_course.users.students
      @top_ten_students = @students.order('course_memberships.sortable_score DESC').limit(10)
      @bottom_ten_students = @students.order('course_memberships.sortable_score ASC').limit(10)
      @assignments = current_course.try(:assignments)
      #@submissions = current_course.try(:assignment_submissions).ungraded.all
    end
  end

end
