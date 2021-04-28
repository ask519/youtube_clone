require 'rails_helper'
require 'capybara'

RSpec.feature "User Profile Page", type: :feature do
  scenario "user should be able to see his uploaded videos" do
    user = create(:user)
    video = create(:video)
    visit "/users/#{user.id}"
    expect(page).to have_text(user.name)
    expect(page).to have_xpath("//img[contains(@src, 'https://youtube-clone-bucket-processed.s3.ap-south-1.amazonaws.com/testvid/thumb.png')]")
  end

  scenario "user shouldn't be able to download or delete other users' videos" do
    user1 = create(:user)
    user2 = create(:user, id: 2, name: "John Smith", uid: "yabbadabbadoo")
    video1 = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    video2 = create(:video, id: 2, name: "John's video", user_id: 2)
    visit "/auth/google_oauth2/callback"
    visit "/users/2"
    expect(page).to have_text(user2.name)
    expect(page).to_not have_text("Download")
    expect(page).to_not have_text("Delete")
  end

  scenario "user should be able to download his own videos" do
    user1 = create(:user)
    user2 = create(:user, id: 2, name: "John Smith", uid: "yabbadabbadoo")
    video1 = create(:video, id: 1, name: "Tester's Video", user_id: 1)
    video2 = create(:video, id: 2, name: "John's video", user_id: 2)
    visit "/auth/google_oauth2/callback"
    visit "/users/1"
    expect(page).to have_text(user1.name)
    expect(page).to have_text("Download")
    expect(page).to have_text("Delete")
  end
end
