class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.find_by_uid(auth_hash['uid'])
    if @user
      @output = "Welcome back, #{@user.name}"
      session[:user_id] = @user.id
    else
      user = User.new
      user.name = auth_hash['info']['name']
      user.email = auth_hash['info']['email']
      user.uid = auth_hash['uid']
      user.save
      @output = "Hello, #{user.name}. You've signed up to YouTube Clone."
      session[:user_id] = user.id
    end
    redirect_to '/'
  end

  def failure
  end

  def destroy
    session[:user_id] = nil
    #@output = "You've logged out!"
    redirect_to '/'
  end
end
