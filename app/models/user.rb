# frozen_string_literal: true

class User < ApplicationRecord
  has_many :photos, dependent: :destroy
  has_one  :my_tweet_app, dependent: :destroy
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
