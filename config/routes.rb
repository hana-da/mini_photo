# frozen_string_literal: true

Rails.application.routes.draw do
  resource :user, only: [] do
    resource :session, only: :new
  end
end
