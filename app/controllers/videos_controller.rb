require 'aws-sdk'

class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    end
  end

  def create
    s3_bucket = Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket(ENV['AWS_S3_BUCKET_NAME'])
    name = File.basename params[:file]
    name_without_ext = File.basename(name, File.extname(name))
    s3_object = s3_bucket.object(name)
    s3_object.upload_file(params[:file])
    @video = Video.new(
      user_id: session[:user_id],
      name: params[:file_name],
      file_name: name,
      thumbnail_url: "https://#{ENV['AWS_S3_BUCKET_NAME']+'-processed'}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{name_without_ext}/thumb.png",
      playlist_url: "https://#{ENV['AWS_S3_BUCKET_NAME']+'-processed'}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{name_without_ext}/#{name_without_ext}.m3u8"
    )
    if @video.save
      redirect_to '/'
    else
      redirect_to '/videos/new'
    end
  end

  def show
    @video = Video.find(params[:id])
    @comments = Comment.where(:reference => params[:id])
  end

  def destroy
  end
end
