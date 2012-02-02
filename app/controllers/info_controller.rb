class InfoController < ApplicationController
  respond_to :html

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
