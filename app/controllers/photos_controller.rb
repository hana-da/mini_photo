# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :login_required!

  def index; end

  def new
    @photo = current_user.photos.build
  end
end
