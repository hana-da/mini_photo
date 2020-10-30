# frozen_string_literal: true

class MyTweetAppsController < ApplicationController
  before_action :login_required!
  before_action :validate_callback_params

  # MyTweet App と OAuth2 連携する際のcallback 受け
  def callback
    MyTweetApp.create_by!(current_user, params[:code])
    session[:access_token] = current_user.my_tweet_app.access_token

    redirect_to user_photos_path
  end

  private def validate_callback_params
    return if params[:code].present?

    flash.alert = params[:error_description].presence || params[:error].presence || '失敗しました'
    redirect_to root_url
  end
end
