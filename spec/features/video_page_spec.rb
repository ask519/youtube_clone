
require 'rails_helper'
require 'capybara'

RSpec.feature "Video Page", type: :feature do
  it "shouldn't let the user like the video without logging in" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/div[1]/div[3]/a").click
    expect(page.current_path).to eq "/"
    element = find(:xpath, "/html/body/nav/div[2]/div/div/a", text: "Tester McTesterson")
    expect(element).to_not eq nil
  end

  it "shouldn't let the user comment on the video without logging in" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/form/textarea").set "Nice video bro"
    click_on "Post Comment"
    expect(page.current_path).to eq "/"
    element = find(:xpath, "/html/body/nav/div[2]/div/div/a", text: "Tester McTesterson")
    expect(element).to_not eq nil
  end

  it "shouldn't let the user like a comment without logging in" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    comment = create(:comment)
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/article/div/nav/div/div/a", text: "0").click
    expect(page.current_path).to eq "/"
    element = find(:xpath, "/html/body/nav/div[2]/div/div/a", text: "Tester McTesterson")
    expect(element).to_not eq nil
  end

  it "should let a logged in user like the video" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    visit "/auth/google_oauth2/callback"
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/div[1]/div[3]/a").click
    expect(page.current_path).to eq "/videos/1/"
    like_count = find(:xpath, "/html/body/div[1]/div/div[1]/div[3]/a/h1", text: "1")
    expect(like_count).to_not eq nil
  end

  it "should let a logged in user comment on the video" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    visit "/auth/google_oauth2/callback"
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/form/textarea").set "Nice video bro"
    click_on "Post Comment"
    expect(page.current_path).to eq "/videos/1"
    comment = find(:xpath, "/html/body/div[1]/div/article/div/div/p", text: "Nice video bro")
    expect(comment).to_not eq nil
  end

  it "should let a logged in user like a comment" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    comment = create(:comment)
    visit "/auth/google_oauth2/callback"
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/article/div/nav/div/div/a", text: "0").click
    expect(page.current_path).to eq "/videos/1/"
    comment_like_count = find(:xpath, "/html/body/div[1]/div/article/div/nav/div/div/a", text: "1")
    expect(comment_like_count).to_not eq nil
  end

  it "should let a logged in user remove his like on a video" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    like = create(:like)
    visit "/auth/google_oauth2/callback"
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/div[1]/div[3]/a", text: "1").click
    expect(page.current_path).to eq "/videos/1/"
    like_count = find(:xpath, "/html/body/div[1]/div/div[1]/div[3]/a", text: "0")
    expect(like_count).to_not eq "nil"
  end

  it "should let a logged in user remove his like on a comment" do
    user = create(:user)
    video = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    comment = create(:comment)
    like = create(:like, like_on: 1)
    visit "/auth/google_oauth2/callback"
    visit "/videos/1"
    find(:xpath, "/html/body/div[1]/div/article/div/nav/div/div/a", text: "1").click
    expect(page.current_path).to eq "/videos/1/"
    comment_like_count = find(:xpath, "/html/body/div[1]/div/article/div/nav/div/div/a", text: "0")
    expect(comment_like_count).to_not eq nil
  end
end
