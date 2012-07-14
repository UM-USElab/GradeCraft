class InfoController < ApplicationController
  respond_to :html

  helper_method :sort_column, :sort_direction
  
  def index
    @users = User.all
    @teams = Team.all
  end

  def show
    @title = "Site Credits"
    @users = User.all
    @teams = Team.all
  end

  def dashboard
    @title = "My Dashboard"
  end

end
