# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  private def login_required!
    redirect_to new_user_session_path unless logged_in?
  end
end
