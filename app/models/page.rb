# == Schema Information
# Schema version: 20101224212728
#
# Table name: pages
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string(255)
#  name_url    :string(255)
#  page_order  :integer
#

class Page < ActiveRecord::Base
  include ActiveModel::Validations
  include ClassMethodsHelper

  class NameValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      Page.validate_name(record, attribute, value, options)
    end
  end

  attr_accessible :name, :description, :title#, :image
  
  validates :name, :presence => true, :name => true
  #validates :image, :presence => true
  validates :description, :presence => true
  
  before_save :generate_name_url
  before_save :sanitize_title
  before_save :sanitize_description
  before_create :generate_page_order
  
  def swap_order!(other)
    other_order = other.page_order
    other.page_order = self.page_order
    self.page_order = other_order
    other.save
    self.save
  end
    
  # def self.name_in_use?(name)
    # find_by_name_url(self.strip_string(name))
  # end
  
  def preview_name_url
    Page.strip_string(name)
  end
   
  private
  
    def generate_name_url
      self.name_url = Page.strip_string(name)
    end
    
    def generate_page_order
      page = Page.last(:order => "page_order")
      order = page ? page.page_order : 0
      self.page_order = order + 1
    end
    
    def sanitize_title
      self.title = Page.clean_title(title)
    end
    
    def sanitize_description
      self.description = Page.clean_description(description)
    end
end
