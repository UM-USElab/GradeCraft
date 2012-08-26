require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  
  protect_from_forgery
  
  Rails.env.production? do
    before_filter :check_url
  end
  
  def check_url
    redirect_to request.protocol + "www." + request.host_with_port + request.fullpath if !/^www/.match(request.host)
  end
  
  before_filter :increment_page_views
  before_filter :require_login, :except => [:not_authenticated]

  include ApplicationHelper

  protected
  def not_authenticated
    if request.env["REMOTE_USER"] != nil
      @user = User.find_by_username(request.env["REMOTE_USER"])
      if @user
        auto_login(@user)
        redirect_to assignments_path
      else
        redirect_to root_url, :alert => "Please login first."
        #We ultimately need to handle Cosign approved users who don't have GradeCraft accounts
      end
    else
      redirect_to root_path, :alert => "Please login first."
    end
  end

  def ensure_staff?
    return not_authenticated unless current_user.is_staff?
  end
  
  private 
  def increment_page_views
    User.increment_counter(:page_views, current_user.id) if current_user
  end   

end
