require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "creation" do
    it "shouldn't save an empty like" do
      user = create(:user)
      like = Like.new
      expect(like).to_not be_valid
    end

    it "shouldn't save a like without a user_id" do
      user = create(:user)
      like = Like.new
      like.reference = 1
      like.like_on = 0
      expect(like).to_not be_valid
    end

    it "shouldn't save a like without a reference" do
      user = create(:user)
      like = Like.new
      like.user_id = 1
      like.like_on = 0
      expect(like).to_not be_valid
    end

    it "shouldn't save a like without a like_on" do
      user = create(:user)
      like = Like.new
      like.user_id = 1
      like.reference = 1
      expect(like).to_not be_valid
    end

    it "shouldn't save a like with an invalid like_on value" do
      user = create(:user)
      like = Like.new
      expect {
        like.like_on = 2
      }.to raise_error(ArgumentError)
    end

    it "should save a like on a video" do
      user = create(:user)
      like = Like.new
      like.user_id = 1
      like.reference = 1
      like.like_on = 0
      expect(like).to be_valid
    end

    it "should save a like on a comment" do
      user = create(:user)
      like = Like.new
      like.user_id = 1
      like.reference = 1
      like.like_on = 1
      expect(like).to be_valid
    end
  end
end