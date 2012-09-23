class CriteriaController < ApplicationController
  def index
    @criteria = Criterium.all
    respond_with(@criteria)
  end

  def show
    @criterium = Criterium.find(params[:id])
    respond_with(@criterium)
  end

  def new
    @criterium = Criterium.new
    respond_with(@criterium)
  end

  def edit
    @criterium = Criterium.find(params[:id])
  end

  def create
    @criterium = Criterium.new(params[:criterium])
    @criterium.save
    respond_with(@criterium)
  end

  def update
    @criterium = Criterium.find(params[:id])
    @criterium.update_attributes(params[:criterium])
    respond_with(@criterium)
  end

  def destroy
    @criterium = Criterium.find(params[:id])
    @criterium.destroy
    respond_with(@criterium)
  end
end
