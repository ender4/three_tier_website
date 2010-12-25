# == Schema Information
# Schema version: 20101224212728
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
#

class Photo < ActiveRecord::Base
  attr_accessible :name
  has_attached_file :image, :styles => { :medium => "300x300>",
                                         :thumb  => "100x100>" },
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/amazon_s3.yml", 
      :path => "/images/:id/:style/:filename"
                            
end
