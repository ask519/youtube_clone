require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "shouldn't save a blank user" do
    user = User.new
    assert_not user.save
  end

  test "shouldn't save a user without name" do
    user = User.new
    user.email = "babymctesterson@gmail.com"
    user.uid = "yooooooooooo"
    assert_not user.save
  end

  test "shouldn't save a user without an email" do
    user = User.new
    user.name = "Baby McTesterson"
    user.uid = "yooooooooooo"
    assert_not user.save
  end

  test "shouldn't save a user without an uid" do
    user = User.new
    user.name = "Baby McTesterson"
    user.email = "babymctesterson@gmail.com"
    assert_not user.save
  end

  test "should save a user with all attributes" do
    user = User.new
    user.name = "Baby McTesterson"
    user.email = "babymctesterson@gmail.com"
    user.uid = "yooooooooooo"
    assert user.save
  end
end
