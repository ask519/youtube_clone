class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @videos = Video.where(user_id: params[:id]).where.not(thumbnail_url: nil)
  end
end
