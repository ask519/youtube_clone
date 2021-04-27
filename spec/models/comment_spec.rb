require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "creation" do
    it "shouldn't save a blank comment" do
      user = create(:user)
      comment = Comment.new
      expect(comment).to_not be_valid
    end

    it "shouldn't save a comment without user_id" do
      user = create(:user)
      comment = Comment.new
      comment.reference = 1
      comment.body = "it Comment"
      expect(comment).to_not be_valid
    end

    it "shouldn't save a comment without reference" do
      user = create(:user)
      comment = Comment.new
      comment.user_id = 1
      comment.body = "it Comment"
      expect(comment).to_not be_valid
    end

    it "shouldn't save a comment without a body" do
      user = create(:user)
      comment = Comment.new
      comment.user_id = 1
      comment.reference = 1
      expect(comment).to_not be_valid
    end

    it "should save a full comment" do
      user = create(:user)
      comment = Comment.new
      comment.user_id = 1
      comment.reference = 1
      comment.body = "it Comment"
      expect(comment).to be_valid
    end
  end
end
