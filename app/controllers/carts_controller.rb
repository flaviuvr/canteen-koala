class CartsController < ApplicationController
  def index
    redirect_to root_path unless logged_in?

    @cart = session[:cart]
    @price = update_price
  end

  def update_price
    price = 0
    return price if @cart.nil?

    @cart.each do |index, item|
      product = Product.find(index)
      price += product.price * item['quantity']
    end
    price
  end

  def remove_cart_items
    session[:cart] = {}

    redirect_to cart_path
  end
end
