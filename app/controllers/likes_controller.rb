class LikesController < ApplicationController
  def new
  end

  def create
    if session[:user_id] == nil
      redirect_to '/login'
    end
    like = Like.new
    like.user_id = session[:user_id]
    like.reference = params[:id]
    like.like_on = params[:like_on]
    like.save
    redirect_to "/videos/#{like.reference}/"
  end

  def destroy
    if session[:user_id] == nil
      redirect_to '/login'
    end
    like = Like.where(:user_id => session[:user_id], :reference => params[:id], :like_on => params[:like_on]).first
    Like.destroy(like.id)
    redirect_to "/videos/#{like.reference}/"
  end
end
