require 'rails_helper'
require 'capybara'

RSpec.feature "NavBar", type: :feature do
  scenario "Should see log in button when not logged in" do
    visit "/"
    expect(page).to have_text("Log In")
  end

  scenario "logged-in user should see his name on the navbar" do
    user = create(:user)
    visit "/auth/google_oauth2/callback"
    expect(page).to have_text "Tester McTesterson"
  end

  scenario "logged-in user should be able to open view profile" do
    user = create(:user)
    visit "/auth/google_oauth2/callback"
    visit "/"
    click_on "View Profile"
    page.find("h1", text: "Tester McTesterson")
    page.find("h1", text: "Videos")
  end

  scenario "logged-in user should be able to open upload" do
    user = create(:user)
    visit "/auth/google_oauth2/callback"
    visit "/"
    click_on "Upload"
    expect(page).to have_text("Tester McTesterson")
    expect(page).to have_text("Upload a Video")
  end

  scenario "logged-in user should be able to log out" do
    user = create(:user)
    visit "/auth/google_oauth2/callback"
    expect(page).to have_text "Tester McTesterson"
    click_on "Log Out"
    expect(page).to have_text "Log In"
  end


end