module ClassMethodsHelper
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    include ApplicationHelper
  end
  
end
