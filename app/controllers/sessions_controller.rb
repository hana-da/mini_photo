# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @form = LoginForm.new
  end
end
