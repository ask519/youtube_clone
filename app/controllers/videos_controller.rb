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
    s3_object = s3_bucket.object(name)
    s3_object.upload_file(params[:file])
    @video = Video.new(
      user_id: session[:user_id],
      name: params[:file_name],
      url_to_hls_playlist: s3_object.public_url,
    )
    if @video.save
      redirect_to '/'
    else
      redirect_to '/videos/new'
    end
  end

  def show
    @video = Video.find(params[:id])
    @test_url = "https://youtube-clone-bucket-processed.s3.ap-south-1.amazonaws.com/testvid/testvid.m3u8"
    @comments = Comment.where(:reference => params[:id])
  end

  def destroy
  end
end
