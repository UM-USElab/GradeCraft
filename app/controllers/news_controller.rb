class NewsController < ApplicationController
  # GET /news
  # GET /news.xml
  def index
    @title = "Course News"
    @news = current_course.news
    respond_with(@news)
  end

  # GET /news/1
  # GET /news/1.xml
  def show
    @title = title
    @news = current_course.news.find(params[:id])
    respond_with(@news)
  end

  # GET /news/new
  # GET /news/new.xml
  def new
    @news = current_course.news.new
    respond_with(@news)
  end

  # GET /news/1/edit
  def edit
    @news = current_course.news.find(params[:id])
  end

  # POST /news
  # POST /news.xml
  def create
    @news = current_course.news.new(params[:news])
    @news.save
    respond_with(@news)
  end

  # PUT /news/1
  # PUT /news/1.xml
  def update
    @news = current_course.news.find(params[:id])
    @news.update_attributes(params[:news])
    respond_with(@news)
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @news = current_course.news.find(params[:id])
    @news.destroy
    respond_with(@news)
  end
end
