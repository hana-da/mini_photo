# frozen_string_literal: true

Rails.application.routes.draw do
  resource :user, only: [] do
    resource :session, only: %i[new create destroy]
    resources :photos, only: %i[index new create]
  end

  get '/oauth/callback', to: 'my_tweet_apps#callback'

  root 'sessions#new'
end
