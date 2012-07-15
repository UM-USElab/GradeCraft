class NewsController < ApplicationController
  # GET /news
  # GET /news.xml
  def index
    @news = News.all
    respond_with(@news)
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @news = News.find(params[:id])
    respond_with(@news)
  end

  # GET /news/new
  # GET /news/new.xml
  def new
    @news = News.new
    respond_with(@news)
  end

  # GET /news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /news
  # POST /news.xml
  def create
    @news = News.new(params[:news])
    @news.save
    respond_with(@news)
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    @news = News.find(params[:id])
    @news.update_attributes(params[:news])
    respond_with(@news)
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @news = News.find(params[:id])
    @news.destroy
    respond_with(@news)
  end
end
