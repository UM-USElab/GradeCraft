class InfoController < ApplicationController

  def index
  end
    
  # GET /info/1
  # GET /info/1.json
  def show
    @group = Info.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info }
    end
  end  

end
