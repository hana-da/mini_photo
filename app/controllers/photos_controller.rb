# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :login_required!, except: :show

  def index
    @photos = current_user.photos.order(created_at: :desc).with_attached_image_file
  end

  def show
    photo = PhotoPublication.find_by!(digest: params[:digest], extension: params[:format]).photo
    send_data(photo.image_file.download, type: photo.image_file.blob.content_type, disposition: :inline)
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    photo_params = params.required(:photo).permit(:title, :image_file)
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      redirect_to user_photos_path
    else
      render :new
    end
  end
end
