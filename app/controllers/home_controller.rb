require "instagram"

class HomeController < ApplicationController
  def index
    token = set_token
    if token
      client = get_instagram_client token
      @popular = client.media_popular
    else
      redirect_to_instagram
    end
  end

private
  def set_token
    token = params.fetch('access_token', nil) || session.fetch('access_token', nil )
    code = params.fetch(:code, nil)
    if token.nil? && code.present?
      configure_instagram
      redirect_uri = ENV['INSTAGRAM_API_RETURN_URI']
      response = Instagram.get_access_token(code, :redirect_uri => redirect_uri)
      token = response.access_token
    else
      configure_instagram
    end
    session['access_token'] = token if token
    token
  end

  def configure_instagram
    Instagram.configure do |config|
      config.client_id = ENV['INSTAGRAM_API_CLIENT_ID']
      config.client_secret = ENV['INSTAGRAM_API_SECRET']
    end
  end

  def get_instagram_client(token)
    Instagram.client(:access_token => token)
  end

  def redirect_to_instagram
    client_id = ENV['INSTAGRAM_API_CLIENT_ID']
    redirect_uri = ENV['INSTAGRAM_API_RETURN_URI']
    params = "client_id=#{client_id}&redirect_uri=#{redirect_uri}&response_type=code"
    redirect_to "https://api.instagram.com/oauth/authorize/?#{params}"
  end
end
