class PredictorController < ApplicationController

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @predictors }
    end
  end
  
  def show
    @title = "Predict Course Grade"
    respond_with @user = User.find(params[:id])
  end
  
end
