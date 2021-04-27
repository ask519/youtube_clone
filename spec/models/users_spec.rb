
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    it "shouldn't save a blank user" do
      user = User.new
      expect(user).to_not be_valid
    end

    it "shouldn't save a user without name" do
      user = User.new
      user.email = "babymctesterson@gmail.com"
      user.uid = "yooooooooooo"
      expect(user).to_not be_valid
    end

    it "shouldn't save a user without email" do
      user = User.new
      user.name = "Baby McTesterson"
      user.uid = "yooooooooooo"
      expect(user).to_not be_valid
    end

    it "shouldn't save a user without uid" do
      user = User.new
      user.name = "Baby McTesterson"
      user.email = "babymctesterson@gmail.com"
      expect(user).to_not be_valid
    end

    it "should save a valid user" do
      user = User.new
      user.name = "Baby McTesterson"
      user.email = "babymctesterson@gmail.com"
      user.uid = "yooooooooooo"
      expect(user).to be_valid
    end
  end
end