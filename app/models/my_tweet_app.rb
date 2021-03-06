# frozen_string_literal: true

class MyTweetApp < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true
  validates :token_type, presence: true

  # OAuth 2.0 認可エンドポイントURL
  AUTHORIZE_URL = 'https://arcane-ravine-29792.herokuapp.com/oauth/authorize'
  # OAuth 2.0 コールバックURL
  REDIRECT_URL = 'http://localhost:3000/oauth/callback'
  # OAuth 2.0 トークンエンドポイントURL
  TOKEN_URL = 'https://arcane-ravine-29792.herokuapp.com/oauth/token'
  # 投稿API エンドポイントURL
  TWEET_API_URL = 'https://arcane-ravine-29792.herokuapp.com/api/tweets'

  CLIENT_ID = ENV.fetch('MY_TWEET_APP_CLIENT_ID')
  CLIENT_SECRET = ENV.fetch('MY_TWEET_APP_CLIENT_SECRET')

  # @return [String] authorization code取得用のURI
  def self.authorize_url(state)
    URI.parse(AUTHORIZE_URL).tap do |uri|
      uri.query = {
        response_type: :code,
        client_id:     CLIENT_ID,
        redirect_uri:  REDIRECT_URL,
        state:         state,
      }.to_query
    end.to_s
  end

  # authorization_code を使って access_token を取得し user に関連付いた MyTweetApp を作る
  #
  # @param [User] user access_token を関連付ける user
  # @param [String] authorization_code access_token を取得するための authorization_code
  # @return [Hash] access token response
  # @raise [HTTPError, HTTPRetriableError, HTTPServerException, HTTPFatalError] レスポンスが 2xx(成功)でなかった場合
  def self.create_by!(user, authorization_code)
    access_token_response = access_token_request(authorization_code)
    user.create_my_tweet_app!(response_params(access_token_response.body))
  end

  class << self
    # @return [Net::HTTP::Response]
    private def access_token_request(authorization_code)
      token_uri = URI.parse(TOKEN_URL)
      Net::HTTP.post_form(token_uri,
                          grant_type:    'authorization_code',
                          code:          authorization_code,
                          redirect_uri:  REDIRECT_URL,
                          client_id:     CLIENT_ID,
                          client_secret: CLIENT_SECRET).tap(&:value)
    end

    # @return [ActionController::StrongParameters]
    private def response_params(json)
      params = ActionController::Parameters.new(JSON.parse(json))
      params.required(:access_token)
      params.permit(:access_token, :token_type, :expires_in, :refresh_token, :scope, :created_at)
    end
  end

  # access_token を使って "MyTweet App" API で投稿する
  #
  # @param [String] text
  # @param [String] url
  # @return [Net::HTTP::Response]
  # @raise [Net::HTTPBadResponse] レスポンスが 201 Created でなかった場合
  def post!(text:, url:)
    tweet_api_uri = URI.parse(TWEET_API_URL)
    request_header = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token}" }
    post_json_string = { text: text, url: url }.to_json

    Net::HTTP.post(tweet_api_uri, post_json_string, request_header).tap do |response|
      raise(Net::HTTPBadResponse, "#{response.code} #{response.message}") unless response.code == '201'
    end
  end
end
