require 'rails_helper'
require 'capybara'

RSpec.feature "Home Page", type: :feature do
  scenario "See list of ready videos" do
    user = create(:user)
    video = create(:video)
    visit "/"
    expect(page).to have_xpath("//img[contains(@src, 'https://youtube-clone-bucket-processed.s3.ap-south-1.amazonaws.com/testvid/thumb.png')]")
  end

  scenario "shouldn't see videos that are being processed" do
    user = create(:user)
    video = build(:video, thumbnail_url: nil, playlist_url: nil)
    visit "/"
    expect(page).to_not have_text("testvid")
  end
end