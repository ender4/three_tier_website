require 'sanitize'

module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  
  def page_link_li(page)
    page_path = (page == home) ? root_path : show_page_path(page.name_url)
    html_class = (page == @page) ? "selected" : "not-selected"
    raw "<li class='#{html_class}'>
        #{pretty_link page.name, page_path,
        :class => html_class, :pretty_classes => "link page"}</li>"
  end
  
  def tag_index_link_li
    html_class = (@tag || @tags) ? "selected" : "not-selected"
    raw "<li class='#{html_class}'>
        #{pretty_link "tag index", tags_path,
        :class => html_class, :pretty_classes => "link tags"}</li>"
  end
  
  def photo_gallery_link_li
    html_class = (@photo || @photos) ? "selected" : "not-selected"
    raw "<li class='#{html_class}'>
        #{pretty_link "photo gallery", photos_path,
        :class => html_class, :pretty_classes => "link photos"}</li>"
  end

  def home
    Page.find(1)
  end
  
  def pretty_text(text, classes = nil)
    @pretty_text_switch = !@pretty_text_switch
    parts = text.split(' ')
    result = ""
    classes = classes.blank? ? "" : "#{classes} "
    classes = "#{classes}alt " if @pretty_text_switch
    parts.each_index do |n|
      part = parts[n]
      clsss = n.odd? ? "#{classes}odd" : "#{classes}even"
      result = "#{result}<span class='#{clsss}'>#{h part.capitalize}</span>"
    end
    raw(result)
  end
  
  def pretty_link(text, path, options = {})
    pretty_classes = options.delete :pretty_classes
    link_to pretty_text(text, pretty_classes), path, options
  end
  
  def title
    str = "#{home.title}"
    if @title
      str = "#{str} | #{@title}"
    elsif @page
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
  
  def new_page?
    @page and @page.id.nil?
  end
  
  def new_tag?
    @tag and @tag.id.nil?
  end
  
  def new_photo?
    @photo and @photo.id.nil?
  end
  
  def viewing_page?
    @page
  end
  
  def viewing_tag?
    @tag 
  end
  
  def viewing_photo?
    @photo
  end
  
  def get_page
    if @page
      @page
    elsif params[:page_name]
      Page.find_by_name_url(params[:page_name])
    elsif params[:page_id]
      Page.find(params[:page_id])
    elsif params[:id]
      Page.find(params[:id])
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

  def get_photo
    if @photo
      @photo
    elsif params[:photo_name]
      Photo.find_by_name_url(params[:photo_name])
    elsif params[:photo_id]
      Photo.find(params[:photo_id])
    elsif params[:id]
      Photo.find(params[:id])
    else
      nil
    end
  end

  def get_tag
    if @tag
      @tag
    elsif params[:tag_name]
      Tag.find_by_name_url(params[:tag_name])
    elsif params[:tag_id]
      Tag.find(params[:tag_id])
    elsif params[:id]
      Tag.find(params[:id])
    else
      nil
    end
  end

  def strip_string(string)
    string.downcase.split(/[^a-z0-9_\-]+/).join
  end
  
  def clean_description(description)
    Sanitize.clean(description, Sanitize::Config::RELAXED)
  end
  
  def clean_title(title)
    title unless title.blank?
  end
  
  def jquery_change_keyup_for(method, selectors)
    selectors.each do |key, selector|
      "$('#{selector}').change('#{method}');
          $('#{selector}').keyup('#{method}');"
    end
  end
  
  def reserved_keywords
    %w[new edit delete users signin signout sessions photos tags pages
        categories items preview photogallery tagindex]
  end
  
  def keyword_regexp
    /\A(#{reserved_keywords.join("|")})\z/i
  end
  
  def all_permissions
    %w[get put post delete]
  end
  
  def permissions_regexp
    perms = all_permissions.join("|")
    /\A(#{perms})(,(#{perms}))*\z/i
  end  
end
