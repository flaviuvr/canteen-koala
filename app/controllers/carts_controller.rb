class CartsController < ApplicationController
  before_action :find_current_cart
  before_action :find_cart_products, only: :index
  before_action :update_price, only: :index

  def index
    redirect_to root_path unless logged_in?
  end

  def update_price
    price = 0
    return price if @current_cart.nil?

    @current_cart.cart_items.each do |prod|
      product = Product.find(prod.product_id)
      price += product.price * prod.quantity
    end
    @price = price
  end

  def remove_cart_items
    @current_cart.cart_items.destroy_all

    redirect_to carts_path
  end

  def find_cart_products
    @products = {}
    @current_cart.cart_items.each do |prod|
      product = Product.find(prod.product_id)
      quantity = prod.quantity
      @products[product] = quantity
    end
  end

  def place_order
    Order.create(cart_id: @current_cart.id)
    @current_cart.update_attribute(:placed_order, true)

    redirect_to carts_path
  end
end
