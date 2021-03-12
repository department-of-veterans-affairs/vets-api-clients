require "rails_helper"

RSpec.describe "Login with API key", :type => :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "with valid API key" do
    VCR.use_cassette("login") do
      visit "/login"

      fill_in "apikey", :with => "SECRET_API_KEY_HERE"
      click_button "Save"

      expect(page).to have_text("Submit HLR")

      click_link "Submit HLR"

      expect(page).to have_text("hlrCreateParameters")
    end
  end

  it "with invalid API key" do
    VCR.use_cassette("invalid_login") do
      visit "/login"

      fill_in "apikey", :with => "INVALID_API_KEY"
      click_button "Save"

      expect(page).to have_text("Submit HLR")

      click_link "Submit HLR"

      expect(page).to have_text("Invalid API key")
      expect(page).not_to have_text("Submit HLR")
    end
  end
end
