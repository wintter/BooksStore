class AuthsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      flash[:success] = 'Hello ' << user.name
      login user
      redirect_to user_path user
    else
      flash.now[:errors] = 'User not found'
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  def log_facebook
    user = User.facebook_login(request.env['omniauth.auth'])
    login user
    reset_session
    redirect_to user_path user
  end

end
