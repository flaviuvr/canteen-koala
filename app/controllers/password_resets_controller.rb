class PasswordResetsController < ApplicationController
  before_action :provide_user, only: %i[edit update]
  before_action :handle_valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest!
      @user.send_password_reset_email
      flash[:info] = 'Check your email for password instructions'

      redirect_to root_path
    else
      flash[:info] = 'Email address not found.'

      redirect_to new_password_reset_path
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(user_params)
      update_user(@user)
    else
      render 'edit'
    end
  end

  def update_user(user)
    reset_session
    user.update_attribute(:reset_digest, nil)
    log_in(user)
    flash[:success] = 'Password has been reset successfully!'

    redirect_to user
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def provide_user
    @user = User.find_by(email: params[:email])
  end

  def handle_valid_user
    redirect_to root_path unless @user&.(@user.activated? && @user.authenticated?(:reset, params[:id]))
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = 'Password reset has expired'
    redirect_to new_password_reset_url
  end
end
