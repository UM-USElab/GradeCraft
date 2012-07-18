class HomeController < ApplicationController
    
  before_filter :require_login, :only => [:login, :register]
  
  def index 
    @news = current_course.news.all
  
  end

end
