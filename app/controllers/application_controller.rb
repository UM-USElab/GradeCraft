class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :require_login, :except => [:not_authenticated]

  protected
  def not_authenticated
    redirect_to root_path, :alert => "Please login first."
  end

  def ensure_staff?
    return not_authenticated unless current_user.is_staff?
  end

end
