class CartsController < ApplicationController
  def index
    @cart = session[:cart]
    @price = update_price
  end

  def update_price
    price = 0
    return price if @cart.nil?

    @cart&.each do |name, quantity|
      product = Product.find(name)
      price += product.price * quantity
    end
    price
  end
end
