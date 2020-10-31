# frozen_string_literal: true

class Photo < ApplicationRecord
  # アップロードできるファイルの拡張子とMime-Type
  # https://www.iana.org/assignments/media-types/media-types.xhtml#image
  ACCEPTABLE_IMAGE_FORMAT = {
    jpeg: 'image/jpeg',
    jpg:  'image/jpeg',
    png:  'image/png',
  }.freeze

  belongs_to :user
  has_one :photo_publication, dependent: :destroy
  has_one_attached :image_file

  validates :title, presence: true, length: { maximum: 30 }
  validates :image_file, presence: true

  validate :must_be_acceptable_image_file

  # 写真を公開状態にする
  #
  # @return [self]
  def publish!
    return self if published?

    blob = image_file.blob
    create_photo_publication!(
      digest:    Base64.decode64(blob.checksum).unpack1('H*'),
      extension: blob.filename.extension_without_delimiter
    ).photo
  end

  # @return [true, false]
  def published?
    !!photo_publication
  end

  private def must_be_acceptable_image_file
    return unless image_file.attached?

    image_file_blob = image_file.blob
    image_file_extension = image_file_blob.filename.extension_without_delimiter.downcase.to_sym
    return if image_file_blob.content_type == ACCEPTABLE_IMAGE_FORMAT[image_file_extension]

    errors.add(:image_file, "は#{ACCEPTABLE_IMAGE_FORMAT.keys.map(&:upcase).join(', ')}形式のみアップロードできます")
  end
end
