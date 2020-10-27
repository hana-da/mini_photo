# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image_file

  validates :title, presence: true, length: { maximum: 30 }
  validates :image_file, presence: true
end
