class PhotosController < ApplicationController
  include ApplicationHelper
  
  def show
    @photo = get_photo
  end
  
  def index
    @photos = Photo.all
  end
  
  def new
  end

  def edit
    @photo = get_photo
  end

  def create
  end

  def update
  end

  def destroy
  end

end
