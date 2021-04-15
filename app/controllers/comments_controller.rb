class CommentsController < ApplicationController
  def new
    if session[:user_id] == nil
      redirect_to '/login'
    end
    @video_id = params[:id]
    @video_name = Video.find(params[:id]).name
  end

  def create
    comment = Comment.new
    comment.user_id = session[:user_id]
    comment.reference = params[:video_id]
    comment.body = params[:body]
    if comment.save
      redirect_to "/videos/#{comment.reference}"
    else
      redirect_to "/videos/#{comment.reference}/comment"
    end
  end
end
