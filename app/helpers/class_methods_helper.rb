module ClassMethodsHelper
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    include ApplicationHelper
    
    def name_in_use?(name)
      find_by_name_url(strip_string(name))
    end
    
    def validate_name(record, attribute, value, options)
      record.errors[ attribute ] << ( options[ :message ] ||
          "must contain at least 1 letter, digit, underscore or dash" ) if
          value.blank? or strip_string(value).blank?
      in_use = name_in_use?(value)
      record.errors[ attribute ] << ( options[ :message ] ||
          "in use" ) if in_use and in_use != record
      record.errors[ attribute ] << ( options[ :message ] ||
          "reserved keyword" ) if value =~ keyword_regexp
    end
  end
  
end
