class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        reset_session
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        session[:session_token] = user.session_token

        redirect_to user
      else
        flash[:warning] = 'Account not activated. Please check your email for the activation link.'

        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Invalid user/password combination. Try again'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end
end
