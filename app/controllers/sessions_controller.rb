class SessionsController < ApplicationController

  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    if @user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = @user.id
      redirect_to '/'
    else
      @error = "Incorrect Email or Password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
  
end
