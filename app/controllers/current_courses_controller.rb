class CurrentCoursesController < ApplicationController

  def change
    
    if course = current_user.courses.where(:id => params[:course_id]).first
      session[:course_id] = course.id
    end
    redirect_to root_url
  end


end
