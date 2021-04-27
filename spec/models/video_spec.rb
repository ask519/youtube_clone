require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "creation" do
    it "shouldn't save a blank Video" do
      video = Video.create()
      expect(video).to_not be_valid
    end

    it "shouldn't save a Video without a user_id" do
      user = create(:user)
      video = Video.new
      video.name = "testvid"
      video.file_name = "testvid.mp4"
      expect(video).to_not be_valid
    end

    it "shouldn't save a Video without a name" do
      user = create(:user)
      video = Video.new
      video.user_id = 1
      video.file_name = "testvid.mp4"
      expect(video).to_not be_valid
    end

    it "shouldn't save a Video without a file_name" do
      user = create(:user)
      video = Video.new
      video.user_id = 1
      video.name = "testvid"
      expect(video).to_not be_valid
    end

    it "should save a Video with all name, file_name and user_id" do
      user = create(:user)
      video = Video.new
      video.user_id = 1
      video.name = "testvid"
      video.file_name = "testvid.mp4"
      expect(video).to be_valid
    end
  end
end