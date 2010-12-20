class PagesController < ApplicationController
  include ApplicationHelper
  
  def show
    @page = get_page
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def get_page
    if @page
      @page
    elsif params[:page_name]
      Page.find_by_name_url(params[:page_name])
    elsif params[:page_id]
      Page.find(params[:page_id])
    else
      home
    end
  end
  
end
