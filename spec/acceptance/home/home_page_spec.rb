require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature "Visiting the home page witha a new session" do
  background do
    @instagram_auth_url = "https://api.instagram.com/oauth/authorize/"

    HomeController.class_eval do
      define_method(:"authorize") do
        render :json => '[{}]'
      end
    end

    Rails.application.routes.draw do
      match '/', to: "home#index"
      match '/oauth/authorize', to: "home#authorize"
    end
  end

  scenario "given a new session" do
    # When I visit the home page
    visit '/'
    # Then I get redirected to the instagram login page.
    current_path.should == "/oauth/authorize/"
  end
end


feature "Visiting the home page with" do
  scenario "with a valid instagram token" do
    # given the valid instagram token
    token = ENV["INSTAGRAM_API_TOKEN_EXAMPLE"]

    # I visit the home page
    visit "/?access_token=#{token}"

    # then I find the app
    page.should have_css('div#app')

    # and an example of the media
    page.should have_css('img.media')
  end
end