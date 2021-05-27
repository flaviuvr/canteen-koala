class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_logged_user
    return if logged_in?

    redirect_to login_path
  end

  def find_current_cart
    cart = Cart.where('user_id = ? AND placed_order = ?', current_user.id, false).first
    return @current_cart ||= cart unless cart.nil?

    @current_cart = Cart.create(user_id: current_user.id)
  end
end
