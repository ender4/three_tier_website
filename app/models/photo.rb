# == Schema Information
# Schema version: 20101225183304
#
# Table name: photos
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  name_url           :string(255)
#

class Photo < ActiveRecord::Base
  include ActiveModel::Validations
  include ClassMethodsHelper

  class NameValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      Photo.validate_name(record, attribute, value, options)
    end
  end

  attr_accessible :name
  
  has_attached_file :image, :styles => { :medium => "300x300>",
                                         :thumb  => "100x100>" },
      :storage => :s3,
      :s3_credentials => "#{Rails.root.to_s}/config/amazon_s3.yml", 
      :path => "/images/:id/:style/:filename"
  
  validates :name, :presence => true, :name => true
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 2.megabyte
  validates_attachment_content_type :image, :content_type => /image/

  before_save :generate_name_url
  
  private
    
    def generate_name_url
      self.name_url = Photo.strip_string(name)
    end
    
end
