class UserSessionsController < ApplicationController

  skip_before_filter :require_login, :except => [:destroy]

  def new
    @title = "Login"
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:user][:email],params[:user][:password],params[:user][:remember_me])
        format.html { redirect_to dashboard_path, :notice => 'Login successful.' }
        format.xml { render :xml => @users, :status => :created, :location => @user }
      else
        @user = User.new
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

end
