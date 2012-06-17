class BadgeSetsController < ApplicationController
  # GET /badge_sets
  # GET /badge_sets.json
  def index
    @title = "Badge Sets"
    @badge_sets = BadgeSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @badge_sets }
    end
  end

  # GET /badge_sets/1
  # GET /badge_sets/1.json
  def show
    @badge_set = BadgeSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @badge_set }
    end
  end

  # GET /badge_sets/new
  # GET /badge_sets/new.json
  def new
    @badge_set = BadgeSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @badge_set }
    end
  end

  # GET /badge_sets/1/edit
  def edit
    @badge_set = BadgeSet.find(params[:id])
  end

  # POST /badge_sets
  # POST /badge_sets.json
  def create
    @badge_set = BadgeSet.new(params[:badge_set])

    respond_to do |format|
      if @badge_set.save
        format.html { redirect_to @badge_set, notice: 'Badge set was successfully created.' }
        format.json { render json: @badge_set, status: :created, location: @badge_set }
      else
        format.html { render action: "new" }
        format.json { render json: @badge_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /badge_sets/1
  # PUT /badge_sets/1.json
  def update
    @badge_set = BadgeSet.find(params[:id])

    respond_to do |format|
      if @badge_set.update_attributes(params[:badge_set])
        format.html { redirect_to @badge_set, notice: 'Badge set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @badge_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badge_sets/1
  # DELETE /badge_sets/1.json
  def destroy
    @badge_set = BadgeSet.find(params[:id])
    @badge_set.destroy

    respond_to do |format|
      format.html { redirect_to badge_sets_url }
      format.json { head :no_content }
    end
  end
end
