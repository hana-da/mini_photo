# frozen_string_literal: true

class MyTweetAppsController < ApplicationController
  before_action :login_required!

  # MyTweet App と OAuth2 連携する際のcallback 受け
  def callback
    if params[:code].blank?
      flash.alert = params[:error_description].presence || params[:error].presence || '失敗しました'
      return redirect_to root_url
    end

    render plain: params
  end
end
