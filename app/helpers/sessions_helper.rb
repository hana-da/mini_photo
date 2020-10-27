# frozen_string_literal: true

module SessionsHelper
  # @return [User,nil] 現在ログインしているUser、ログインしていない場合はnil
  private def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # @return [true, false] 現在ログインしているか
  private def logged_in?
    current_user.instance_of?(User)
  end
end
