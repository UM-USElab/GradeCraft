class HomeController < ApplicationController
    
  before_filter :require_login, :only => [:login, :register]
  
  def index 
    if current_user
      if current_user.is_admin?
        @title = "Course Dashboard"
      else
        @title = "My Dashboard"
        @user = current_user
      end
      @teams = current_course.try(:teams)
      @users = current_course.try(:users)
      @badges = current_course.badges
      @students = @users.students
      @top_ten_students = @students.order('sortable_score DESC').limit(10)
      @bottom_ten_students = @students.order('sortable_score ASC').limit(10)
      @assignments = current_course.try(:assignments)
      @submissions = current_course.try(:assignment_submissions)
    end
  end

end
