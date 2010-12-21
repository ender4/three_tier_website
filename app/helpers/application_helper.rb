module ApplicationHelper
    
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  def home
    Page.find(1)
  end
  
  def title  
    str = "#{home.title}"
    if @page
      if @page.title.blank?
        str = "#{str} | #{@page.name}"
      elsif @page != home
        str = @page.title
      end
      if @category
        if @category.title.blank?
          str = "#{str} | #{@category.name}"
        else
          str = @category.title
        end
        if @item
          if @item.title.blank?
            str = "#{str} | #{@item.name}"
          else
            str = @item.title
          end
        end
      end
    elsif @user
      str = "#{str} | #{@user.name}"
    end
    
    if @title_suffix
      "#{str} | #{@title_suffix}" 
    else
      str
    end
  end
  
  def last_edited_on
    Page.first(:order => "updated_at DESC").updated_at
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
  
  def get_category
    if @category
      @category
    elsif params[:category_name]
      Category.find_by_name_url(params[:category_name])
    elsif params[:category_id]
      Category.find(params[:category_id])
    else
      nil
    end
  end

  def get_item
    if @item
      @item
    elsif params[:item_name]
      Item.find_by_name_url(params[:item_name])
    elsif params[:item_id]
      Item.find(params[:item_id])
    else
      nil
    end
  end
  
end
