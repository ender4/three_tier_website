class PagesController < ApplicationController
  include ApplicationHelper
  
  before_filter :authenticate, :except => [:show]
  before_filter :authenticate_put, :only => [:edit, :update]
  before_filter :authenticate_post, :only => [:new, :create]
  before_filter :authenticate_delete, :only => [:destroy]
  
  def show
    @page = get_page
  end

  def new
    @page = Page.new
    @title = "New page"
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:success] = "Page created."
      redirect_to show_page_path(@page.name_url)
    else
      @title = "New page"
      render 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
    @title = "Edit page"
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:success] = "Page updated."
      redirect_to show_page_path(@page.name_url)
    else
      @title = "Edit page"
      render 'edit'
    end
  end

  def destroy
    page=Page.find(params[:id])
    if protected_page?(page)
      flash[:error] =
          "Page: '#{page.name}' is protected and may not be deleted."
    else
      page.destroy
      flash[:success] = "Page destroyed."
    end
    redirect_to root_path
  end
    
end
