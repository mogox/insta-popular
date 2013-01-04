require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    context "new session" do
      it "redirects to the instagram login" do
        Instagram.should_not_receive(:client)
        get 'index'
        host = "https://api.instagram.com/oauth/authorize/"
        client_id = ENV['INSTAGRAM_API_CLIENT_ID']
        redirect_uri = ENV['INSTAGRAM_API_RETURN_URI']
        params = "?client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code"
        response.should redirect_to("#{host}#{params}")
      end
    end

    context "with a user already authenticated, with an existing token" do
      before do
        controller.stub(:session) { { 'access_token' => '123ABC' } }
      end

      it "returns http success" do
        Instagram.stub_chain(:client, :media_popular) { [] }
        get 'index'
        response.should be_success
      end
    end

    context "registering a new session" do
      it "stores the code in the session" do
        Instagram.stub_chain(:client, :media_popular) { [] }
        session['access_token'].should be_nil
        get 'index', :access_token => '123ABC'
        session['access_token'].should eq '123ABC'
      end
    end
  end
end
