class UserGradeWeightsController < ApplicationController
  def index
    @user_grade_weights = UserGradeWeight.all
    respond_with(@user_grade_weights)
  end

  def show
    @user_grade_weight = UserGradeWeight.find(params[:id])
    respond_with(@user_grade_weight)
  end

  def new
    @user_grade_weight = UserGradeWeight.new
    respond_with(@user_grade_weight)
  end

  def edit
    @user_grade_weight = UserGradeWeight.find(params[:id])
  end

  def create
    @user_grade_weight = UserGradeWeight.new(params[:user_grade_weight])
    @user_grade_weight.save
    respond_with(@user_grade_weight)
  end

  def update
    @user_grade_weight = UserGradeWeight.find(params[:id])
    @user_grade_weight.update_attributes(params[:user_grade_weight])
    respond_with(@user_grade_weight)
  end

  def destroy
    @user_grade_weight = UserGradeWeight.find(params[:id])
    @user_grade_weight.destroy
    respond_with(@user_grade_weight)
  end
end
