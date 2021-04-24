require 'aws-sdk-s3'

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @videos = Video.where(user_id: params[:id]).where.not(thumbnail_url: nil)
  end

  def download_video
    video_key = Video.find(params[:id]).file_name
    presigner = Aws::S3::Presigner.new
    video_url = presigner.presigned_url(:get_object, bucket: ENV['AWS_S3_BUCKET_NAME'], key: video_key, expires_in: 18000)
    redirect_to video_url
  end
end
