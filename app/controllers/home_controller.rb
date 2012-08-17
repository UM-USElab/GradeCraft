class HomeController < ApplicationController
    
  before_filter :require_login, :only => [:login, :register]
  
  def index 

  end

end
