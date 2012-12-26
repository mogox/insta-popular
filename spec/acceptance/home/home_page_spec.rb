require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature "Visiting the home page" do
  background do
  end

  scenario "given a new session" do
    # When I visit the home page
    visit '/'
    # Then I get redirected to the instagram login page.
    current_path.should == 'https://api.instagram.com/oauth/authorize/'
  end

  scenario "With a valid instagram token" do
    token = ENV["INSTAGRAM_API_TOKEN_EXAPLE"]
    visit "/#access_token=#{token}"
    page.should have_css('table.pupular')
    page.should have_css('img.media')
  end
end