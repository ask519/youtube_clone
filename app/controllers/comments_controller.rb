class CommentsController < ApplicationController
  def new
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    else
      @video_id = params[:id]
      @video_name = Video.find(params[:id]).name
    end
  end

  def create
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    else
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
end
