class GradeSchemesController < ApplicationController
  # GET /grade_schemes
  # GET /grade_schemes.json
  def index
    @grade_schemes = GradeScheme.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grade_schemes }
    end
  end

  # GET /grade_schemes/1
  # GET /grade_schemes/1.json
  def show
    @grade_scheme = GradeScheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grade_scheme }
    end
  end

  # GET /grade_schemes/new
  # GET /grade_schemes/new.json
  def new
    @grade_scheme = GradeScheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grade_scheme }
    end
  end

  # GET /grade_schemes/1/edit
  def edit
    @grade_scheme = GradeScheme.find(params[:id])
  end

  # POST /grade_schemes
  # POST /grade_schemes.json
  def create
    @grade_scheme = GradeScheme.new(params[:grade_scheme])

    respond_to do |format|
      if @grade_scheme.save
        format.html { redirect_to @grade_scheme, notice: 'Grade scheme was successfully created.' }
        format.json { render json: @grade_scheme, status: :created, location: @grade_scheme }
      else
        format.html { render action: "new" }
        format.json { render json: @grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grade_schemes/1
  # PUT /grade_schemes/1.json
  def update
    @grade_scheme = GradeScheme.find(params[:id])

    respond_to do |format|
      if @grade_scheme.update_attributes(params[:grade_scheme])
        format.html { redirect_to @grade_scheme, notice: 'Grade scheme was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grade_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grade_schemes/1
  # DELETE /grade_schemes/1.json
  def destroy
    @grade_scheme = GradeScheme.find(params[:id])
    @grade_scheme.destroy

    respond_to do |format|
      format.html { redirect_to grade_schemes_url }
      format.json { head :ok }
    end
  end
end
