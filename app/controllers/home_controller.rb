class HomeController < ApplicationController
    
  before_filter :require_login, :only => [:home]

end
