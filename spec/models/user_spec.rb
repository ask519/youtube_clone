
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    it "shouldn't save a blank user" do
      user = User.new
      expect(user).to_not be_valid
    end

    it "shouldn't save a user without name" do
      user = User.new
      user.email = "testermctesterson@gmail.com"
      user.uid = "yooooooooooo"
      expect(user).to_not be_valid
    end

    it "shouldn't save a user without email" do
      user = User.new
      user.name = "Tester McTesterson"
      user.uid = "yooooooooooo"
      expect(user).to_not be_valid
    end

    it "shouldn't save a user without uid" do
      user = User.new
      user.name = "Tester McTesterson"
      user.email = "testermctesterson@gmail.com"
      expect(user).to_not be_valid
    end

    it "should save a valid user" do
      user = User.new
      user.name = "Tester McTesterson"
      user.email = "testermctesterson@gmail.com"
      user.uid = "yooooooooooo"
      expect(user).to be_valid
    end
  end
end