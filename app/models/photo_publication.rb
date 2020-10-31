# frozen_string_literal: true

class PhotoPublication < ApplicationRecord
  belongs_to :photo

  validates :digest,    presence: true
  validates :extension, presence: true
end
