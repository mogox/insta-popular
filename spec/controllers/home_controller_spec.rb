require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    context "new session" do
      it "redirects to the instagram login" do
        get 'index'
        response.should redirect_to("https://api.instagram.com/oauth/authorize/")
      end
    end

    context "with a user already authenticated, with an existing token" do
      before do
        controller.stub(:session){ :code }
        answer = { meta: {code: '200 Ok'} }
      end

      it "returns http success" do
        InstagramAPI.should_receive(:load).with(:'media/popular'){ answer }
        get 'index'
        response.should be_success
      end
    end
  end
end
