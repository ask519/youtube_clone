require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "shouldn't save an empty like" do
    like = Like.new
    assert_not like.save
  end

  test "shouldn't save a like without a user_id" do
    like = Like.new
    like.reference = 1
    like.like_on = 0
    assert_not like.save
  end

  test "shouldn't save a like without a reference" do
    like = Like.new
    like.user_id = 1
    like.like_on = 0
    assert_not like.save
  end

  test "shouldn't save a like without a like_on" do
    like = Like.new
    like.user_id = 1
    like.reference = 1
    assert_not like.save
  end

  test "shouldn't save a like with an invalid like_on value" do
    like = Like.new
    assert_raises ArgumentError do
      like.like_on = 2
    end
  end

  test "should save a like on a video" do
    like = Like.new
    like.user_id = 1
    like.reference = 1
    like.like_on = 0
    assert like.save
  end

  test "should save a like on a comment" do
    like = Like.new
    like.user_id = 1
    like.reference = 1
    like.like_on = 1
    assert like.save
  end
end
