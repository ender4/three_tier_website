class SessionsController < ApplicationController
  
  def new
    if signed_in?
      redirect_to root_path,
          :notice => "You must sign out before signing in as a different user."
    else
      @title = "Sign in"
    end
  end
  
  def create
    user = User.authenticate(params[:session][:name],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid name/password combination."
      @title = "Sign in"
      render 'new'
    else
      signin user
      redirect_back_or user
    end
  end
  
  def destroy
    signout
    redirect_to root_path
  end

end
