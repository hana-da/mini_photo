# frozen_string_literal: true

class MyTweetAppsController < ApplicationController
  before_action :login_required!
  before_action :validate_callback_params, only: :callback

  # MyTweet App と OAuth2 連携する際のcallback 受け
  def callback
    MyTweetApp.create_by!(current_user, params[:code])
    session[:access_token] = current_user.my_tweet_app.access_token

    redirect_to user_photos_path
  end

  # MyTweet App へ投稿する
  def create
    if session[:access_token]
      current_user.my_tweet_app.post!(text: published_photo.title,
                                      url:  published_photo_url)
      flash.notice = 'MyTweetAppに投稿しました'
    else
      flash.alert = 'MyTweetAppと連携していません'
    end
    redirect_to user_photos_path
  end

  private def published_photo
    @published_photo ||= current_user.photos.find(params[:photo_id]).publish!
  end

  private def published_photo_url
    photo_publication = published_photo.photo_publication
    photo_url(digest: photo_publication.digest, format: photo_publication.extension)
  end

  private def validate_callback_params
    return if params[:code].present?

    flash.alert = params[:error_description].presence || params[:error].presence || '失敗しました'
    redirect_to root_url
  end
end
