# frozen_string_literal: true

class MyTweetApp < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true
  validates :token_type, presence: true

  # OAuth 2.0 認可エンドポイントURL
  AUTHORIZE_URL = 'https://arcane-ravine-29792.herokuapp.com/oauth/authorize'
  # OAuth 2.0 コールバックURL
  REDIRECT_URL = 'http://localhost:3000/oauth/callback'

  CLIENT_ID = ENV.fetch('MY_TWEET_APP_CLIENT_ID')

  # @return [String] authorization code取得用のURI
  def self.authorize_url
    URI.parse(AUTHORIZE_URL).tap do |uri|
      uri.query = {
        response_type: :code,
        client_id:     CLIENT_ID,
        redirect_uri:  REDIRECT_URL,
      }.to_query
    end.to_s
  end
end
