require 'aws-sdk'

class VideosController < ApplicationController
  def index
    @videos = Video.where.not(thumbnail_url: nil)
  end

  def new
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    end
  end

  def create
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    else
      s3_bucket = Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket(ENV['AWS_S3_BUCKET_NAME'])
      sqs_client = Aws::SQS::Client.new(region: ENV['AWS_REGION'])
      sqs_url = sqs_client.get_queue_url(queue_name: ENV['AWS_SQS_QUEUE_NAME']).queue_url

      name = File.basename params[:file]
      file = params[:file]

      @video = Video.new(
        user_id: session[:user_id],
        name: params[:file_name],
        file_name: name,
        )

      s3_object = s3_bucket.object(name)
      s3_object.upload_file(file)

      url_update_scheduler = Rufus::Scheduler.singleton
      url_update_scheduler.every '60s' do
        resp = sqs_client.receive_message({queue_url: sqs_url, message_attribute_names: ["All"], max_number_of_messages: 1, wait_time_seconds: 10})
        # Rails.logger.info "Fetched #{resp.messages.count} message(s)"
        # Rails.logger.flush
        if resp.messages.count == 1
          message = resp.messages[0]
          file_name = message.message_attributes["FileName"]["string_value"]
          file_name_without_ext = File.basename(file_name, File.extname(file_name))
          vid = Video.where(file_name: file_name)[0]
          # Rails.logger.info "Video id: #{vid.id}, Video name: #{vid.name}"
          # Rails.logger.flush
          vid.thumbnail_url = "https://#{ENV['AWS_S3_BUCKET_NAME']+'-processed'}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{file_name_without_ext}/thumb.png"
          vid.playlist_url = "https://#{ENV['AWS_S3_BUCKET_NAME']+'-processed'}.s3.#{ENV['AWS_REGION']}.amazonaws.com/#{file_name_without_ext}/#{file_name_without_ext}.m3u8"
          vid.save

          user = User.find(vid.user_id)
          UserMailer.upload_successful(user, vid).deliver_now

          url_update_scheduler.shutdown
        end
      end

      if @video.save
        redirect_to '/'
      else
        redirect_to '/videos/new'
      end
    end
  end

  def show
    @video = Video.find(params[:id])
    @comments = Comment.where(:reference => params[:id])
  end

  def destroy
    if session[:user_id] == nil
      redirect_to '/auth/google_oauth2'
    else
      upload_s3_bucket = Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket(ENV['AWS_S3_BUCKET_NAME'])
      processed_s3_bucket = Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket(ENV['AWS_S3_BUCKET_NAME']+'-processed')
      @video = Video.find(params[:id])
      user_id = @video.user_id

      upload_key = @video.file_name
      processed_key = File.basename(upload_key, File.extname(upload_key)) + '/'
      upload_s3_bucket.object(upload_key).delete
      processed_s3_bucket.objects({prefix: processed_key}).each do |object|
        processed_s3_bucket.object(object.key).delete
      end

      UserMailer.delete_successful(User.find(@video.user_id), @video).deliver_now

      @video.destroy

      redirect_to "/users/#{user_id}"
    end
  end

  def download_video
    video_key = Video.find(params[:id]).file_name
    presigner = Aws::S3::Presigner.new
    video_url = presigner.presigned_url(:get_object, bucket: ENV['AWS_S3_BUCKET_NAME'], key: video_key, expires_in: 18000)
    redirect_to video_url
  end
end
