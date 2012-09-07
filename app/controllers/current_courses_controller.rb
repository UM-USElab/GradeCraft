class CurrentCoursesController < ApplicationController

  respond_to :json 

  def change
    if course = current_user.courses.where(:id => params[:course_id]).first
      session[:course_id] = course.id
    end
    redirect_to root_url
  end

  def show
    respond_with current_course.as_json(only: [:id], methods: [:total_points])
  end
  
end
