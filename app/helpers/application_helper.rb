module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  def home
    Page.find(1)
  end
  
  def title  
    str = "#{home.title} | #{@page.name}"
    str = @page.title unless @page.title.blank?
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
    str = "#{str} | #{@title_suffix}" if @title_suffix
    str
  end
  
  def last_edited_on
    Page.first(:order => "updated_at DESC").updated_at
  end
  
end
