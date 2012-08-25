class BadgesController < ApplicationController

  before_filter :ensure_staff?, :only=>[:new,:edit,:create,:update,:destroy]

  def index
    @title = "View All Badges"
    @badges = current_course.badges.all
  end

  def show
    @badge = current_course.badges.find(params[:id])
    @title = @badge.name

    respond_to do |format|
      format.html
      format.json { render json: @badge }
    end
  end

  def new
    @title = "Create a New Badge"
    @badge = Badge.new
    respond_to do |format|
      format.html
      format.json { render json: @badge }
    end
  end

  def edit
    @badge = current_course.badges.find(params[:id])
    @title = "Edit #{@badge.name} Badge"
  end

  def create
    @badge = Badge.create(params[:badge])

    respond_to do |format|
      if @badge.save
        format.html { redirect_to @badge, notice: 'Badge was successfully created.' }
        format.json { render json: @badge, status: :created, location: @badge }
      else
        format.html { render action: "new" }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @badge = Badge.find(params[:id])

    respond_to do |format|
      if @badge.update_attributes(params[:badge])
        format.html { redirect_to @badge, notice: 'Badge was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @badge = Badge.find(params[:id])
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to badges_url }
      format.json { head :ok }
    end
  end
  
  def onetime
    @badges = Badge.find_all_by_occurrence(true)
  end
end
