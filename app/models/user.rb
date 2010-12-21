class User < ActiveRecord::Base
  attr_accessible :name, :permissions
  
  perms = "get|put|post|delete"
  permissions_regexp = /\A(#{perms})(,(#{perms}))*\z/i
  
  validates :name, :presence => true,
                   :length => { :maximum => 64, :minimum => 4 },
                   :uniqueness => { :case_sensitive => false }
  validates :permissions, :presence => true,
                          :format => { :with => permissions_regexp }
end
