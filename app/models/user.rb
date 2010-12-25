# == Schema Information
# Schema version: 20101224212728
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  permissions        :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'
#require 'model_helper'

class User < ActiveRecord::Base
  include ClassMethodsHelper
  
  attr_accessor :password
  #attr_accessible :name, :permissions, :password, :password_confirmation
  
  validates :name, :presence => true,
                   :length => { :within => 4..64 },
                   :uniqueness => { :case_sensitive => false }
  validates :permissions, :presence => true,
                          :format => { :with => User.permissions_regexp }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..64 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def may_get?
    permissions =~ /get/i
  end
  
  def may_put?
    permissions =~ /put/i
  end
  
  def may_post?
    permissions =~ /post/i
  end
  
  def may_delete?
    permissions =~ /delete/i
  end
  
  def self.authenticate(name, submitted_password)
    user = find_by_name(name)
    if user.nil? or not(user.has_password?(submitted_password))
      nil
    else
      user
    end
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
