class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
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
      redirect_to user
    end
  end
  
  def destroy
    signout
    redirect_to root_path
  end

end
