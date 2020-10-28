# frozen_string_literal: true

Rails.application.routes.draw do
  resource :user, only: [] do
    resource :session, only: %i[new create]
    resources :photos, only: %i[index new create]
  end
end
