class HomeController < ApplicationController
    
  before_filter :require_login, :only => [:login, :register]

end
