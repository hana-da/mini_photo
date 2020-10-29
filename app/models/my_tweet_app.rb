# frozen_string_literal: true

class MyTweetApp < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true
  validates :token_type, presence: true
end
