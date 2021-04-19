class LikesController < ApplicationController
  def new
  end

  def create
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    else
      like = Like.new
      like.user_id = session[:user_id]
      like.reference = params[:reference]
      like.like_on = params[:like_on]
      like.save
      redirect_to "/videos/#{params[:video_id]}/"
    end
  end

  def destroy
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    else
      like = Like.where(:user_id => session[:user_id], :reference => params[:reference], :like_on => params[:like_on]).first
      Like.destroy(like.id)
      redirect_to "/videos/#{params[:video_id]}/"
    end
  end
end
