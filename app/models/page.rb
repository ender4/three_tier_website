# == Schema Information
# Schema version: 20101210003903
#
# Table name: pages
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  image       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Page < ActiveRecord::Base
  require 'model_helper'
  include ActiveModel::Validations
  include ModelHelper

  class NameValidator < ActiveModel::EachValidator
    def validate_each( record, attribute, value )
      record.errors[ attribute ] << ( options[ :message ] ||
          "must contain at least 1 letter, digit, underscore or dash" ) if
          Page.strip_string(value).empty?
      in_use = Page.name_in_use?(value)
      record.errors[ attribute ] << ( options[ :message ] ||
          "in use" ) if in_use and in_use != record
      record.errors[ attribute ] << ( options[ :message ] ||
          "reserved keyword" ) if value =~ Page.keyword_regexp
    end
  end

  attr_accessible :name, :image, :description, :title
  
  validates :name, :presence => true, :name => true
  validates :image, :presence => true
  validates :description, :presence => true
  
  before_save :generate_name_url
  before_create :generate_page_order
  
  def swap_order!(other)
    other_order = other.page_order
    other.page_order = self.page_order
    self.page_order = other_order
    other.save
    self.save
  end
    
  def self.name_in_use?(name)
    find_by_name_url(self.strip_string(name))
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
end
