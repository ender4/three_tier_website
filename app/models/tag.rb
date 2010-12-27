# == Schema Information
# Schema version: 20101225183304
#
# Table name: tags
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  name_url   :string(255)
#

class Tag < ActiveRecord::Base
  include ActiveModel::Validations
  include ClassMethodsHelper

  class NameValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      Tag.validate_name(record, attribute, value, options)
    end
  end

  attr_accessible :name
  
  validates :name, :presence => true, :name => true

  before_save :generate_name_url
  
  private
    
    def generate_name_url
      self.name_url = Tag.strip_string(name)
    end
    
end
