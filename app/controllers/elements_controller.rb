class ElementsController < ApplicationController

  before_filter :ensure_staff?
  
  def index 
    @badge = Badge.find(params[:badge_id])
    @title = "#{@badge.name} Elements"
    @elements = @badge.elements.all
    respond_to do |format|
      format.html 
      format.json { render json: @elements.as_json(only: [:id, :name, :description]) }
    end
  end

  def show
    @badge = Badge.find(params[:badge_id])
    @title = "#{@badge.name} Element"
    @element = Element.find(params[:id])
    respond_with(@element)
  end

  def new
    @badge = Badge.find(params[:badge_id])
    @title = "Create a New #{@badge.name} Element"
    @element = @badge.elements.new(params[:element])
    respond_with(@badge)
  end

  def edit
    @badge = Badge.find(params[:badge_id])
    @title = "Edit #{@badge.name} Grading Element"
    @element = @badge.elements.find(params[:id])
    
    respond_with(@badge)
  end

  def create
    @badge = Badge.find(params[:badge_id])
    @element = @badge.elements.build(params[:element])
    
    respond_to do |format|
      if @element.save
        format.html { redirect_to @badge, notice: 'Element was successfully created.' }
        format.json { render json: @element, status: :created, location: @element }
      else
        format.html { render action: "new" }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @badge = Badge.find(params[:badge_id])
    @element = @badge.elements.find(params[:id])
    @element.update_attributes(params[:element])
    respond_with @badge
  end

  def destroy
    @badge = Badge.find(params[:badge_id])
    @element = @badge.course_grade_scheme_elements.find(params[:id])
    @element.destroy
    
    respond_to do |format|
      format.html { redirect_to course_grade_scheme_path(@badge), notice: 'Grade Scheme Element was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
