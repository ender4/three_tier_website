module ModelHelper
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def strip_string(string)
      string.downcase.split(/[^a-z0-9_\-]+/).join
    end
  
    def reserved_keywords
      %w[new edit delete users]
    end
    
    def keyword_regexp
      /\A#{reserved_keywords.join("|")}\z/i
    end
    
    def all_permissions
      %w[get put post delete]
    end
    
    def permissions_regexp
      perms = all_permissions.join("|")
      /\A(#{perms})(,(#{perms}))*\z/i
    end
  
  end
  
end
