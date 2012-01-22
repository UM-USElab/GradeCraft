class InfoController < ApplicationController
  respond_to :html

  def show
    @title = "Site Credits"
  end

  def dashboard
    @title = "My Dashboard"
  end


end
