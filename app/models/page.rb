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
  include ActiveModel::Validations

  class NameValidator < ActiveModel::EachValidator
    def validate_each( record, attribute, value )
      record.errors[ attribute ] << ( options[ :message ] ||
          "must contain at least 1 letter, digit, underscore or dash" ) if
          Page.strip_string(value).empty?
      record.errors[ attribute ] << ( options[ :message ] ||
          "in use" ) unless Page.name_in_use?(value) == record
      record.errors[ attribute ] << ( options[ :message ] ||
          "reserved keyword" ) if value =~ /\Anew|edit\z/i
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
    find_by_name_url(strip_string(name))
  end
  
  def self.strip_string(string)
    string.downcase.split(/[^a-z0-9_\-]+/).join
  end
    
  private
  
    def generate_name_url
      self.name_url = Page.strip_string(name)
    end
    
    def generate_page_order
      page = Page.last(:order => "page_order")
      order = page ? page.page_order : nil
      self.page_order = order ? order + 1 : 1
    end
end
