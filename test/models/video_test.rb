require "test_helper"

class VideoTest < ActiveSupport::TestCase
  test "shouldn't save a blank video" do
    video = Video.new
    assert_not video.save
  end

  test "should'nt save a video without an user_id" do
    video = Video.new
    video.name = "testvid"
    video.file_name = "testvid.mp4"
    assert_not video.save
  end

  test "shouldn't save a video without a name" do
    video = Video.new
    video.user_id = 1
    video.file_name = "testvid.mp4"
    assert_not video.save
  end

  test "shouldn't save a video without a file_name" do
    video = Video.new
    video.user_id = 1
    video.name = "testvid"
    assert_not video.save
  end

  test "should save a video with name, file_name and user id" do
    video = Video.new
    video.user_id = 1
    video.name = "testvid"
    video.file_name = "testvid.mp4"
    assert video.save
  end
end
