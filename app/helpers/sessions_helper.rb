module SessionsHelper
  
  def signin(user)
    session[:user_id] = user.id
    current_user = user
  end
  
  def signout
    session[:user_id] = nil
    current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    not current_user.nil?
  end
  
  private
  
    def user_from_remember_token
      User.find_by_id(session[:user_id])
    end
    
end
