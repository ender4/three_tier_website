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

  def may_get?
    current_user.may_get?
  end
  
  def may_put?
    current_user.may_put?
  end
  
  def may_post?
    current_user.may_post?
  end
  
  def may_delete?
    current_user.may_delete?
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def authenticate_put
    protect_access unless may_put?
  end
  
  def authenticate_post
    protect_access unless may_post?
  end
  
  def authenticate_delete
    protect_access unless may_delete?
  end
  
  def protected_page?(page)
    page == home
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def protect_access
    redirect_to root_path,
        :notice => "You do not have permission to access this action."
  end
  
  def redirect_back_or(default=root_path)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
  
    def user_from_remember_token
      User.find_by_id(session[:user_id])
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def clear_return_to
      session[:return_to] = nil
    end
end
