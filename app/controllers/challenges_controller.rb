class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
    respond_with(@challenges)
  end

  def show
    @challenge = Challenge.find(params[:id])
    respond_with(@challenge)
  end

  def new
    @challenge = Challenge.new
    respond_with(@challenge)
  end

  def edit
    @challenge = Challenge.find(params[:id])
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    @challenge.save
    respond_with(@challenge)
  end

  def update
    @challenge = Challenge.find(params[:id])
    @challenge.update_attributes(params[:challenge])
    respond_with(@challenge)
  end

  def destroy
    @challenge = Challenge.find(params[:id])
    @challenge.destroy
    respond_with(@challenge)
  end
end
