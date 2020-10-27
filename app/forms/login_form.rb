# frozen_string_literal: true

class LoginForm
  include ActiveModel::Model

  attr_accessor :username, :password

  validates :username, presence: true
  validates :password, presence: true
end
