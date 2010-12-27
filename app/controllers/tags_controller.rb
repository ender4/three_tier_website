class TagsController < ApplicationController
  include ApplicationHelper
  
  def show
    @tag = get_tag
    @title = @tag.name
  end

  def index
    @tags = Tag.all
    @title = "Tag index"
  end

  def new
  end

  def create
  end

  def edit
    @tag = get_tag
  end

  def update
  end

  def delete
  end

end
