class PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
  end
  
  def index
    @photos = Photo.all
  end
  
  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
