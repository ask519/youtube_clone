require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "shouldn't save a blank comment" do
    comment = Comment.new
    assert_not comment.save
  end

  test "shouldn't save a comment without user_id" do
    comment = Comment.new
    comment.reference = 1
    comment.body = "Test Comment"
    assert_not comment.save
  end

  test "shouldn't save a comment without reference" do
    comment = Comment.new
    comment.user_id = 1
    comment.body = "Test Comment"
    assert_not comment.save
  end

  test "shouldn't save a comment without a body" do
    comment = Comment.new
    comment.user_id = 1
    comment.reference = 1
    assert_not comment.save
  end

  test "should save a full comment" do
    comment = Comment.new
    comment.user_id = 1
    comment.reference = 1
    comment.body = "Test Comment"
    assert comment.save
  end
end
