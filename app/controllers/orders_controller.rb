class OrdersController < ApplicationController
  before_action :find_user_orders, only: %i[index show]
  before_action :find_order_items, only: :show
  before_action :find_order_price, only: :show

  def index
    find_all_orders if current_user.admin?
  end

  def show; end

  def find_user_orders
    @orders = {}
    order_carts = Cart.where('user_id = ? AND placed_order = ?', current_user.id, true)

    order_carts.each do |cart|
      current_order = Order.where('cart_id = ?', cart.id).last
      user = User.find(Cart.find(current_order.cart_id).user_id)
      insert_order_info(current_order, user)
    end
  end

  def find_all_orders
    order_carts = Cart.where('placed_order = ?', true)

    order_carts.each do |cart|
      current_order = Order.where('cart_id = ?', cart.id).last
      user = User.find(Cart.find(current_order.cart_id).user_id)
      insert_order_info(current_order, user)
    end
  end

  def insert_order_info(order, user)
    @orders[order.id] = {}
    @orders[order.id][:user_name] = user.name
    @orders[order.id][:date] = order.created_at
    @orders[order.id][:status] = order.handled_by_admin
  end

  def find_order_items
    @order = Order.find(params[:id])
    @order_items = {}
    order_cart = Cart.find(@order.id)
    items = CartItem.where('cart_id = ?', order_cart.id)

    items.each do |item|
      product = Product.find(item.product_id)
      insert_item_props(product, item)
    end
  end

  def insert_item_props(product, item)
    @order_items[product.id] = {}
    @order_items[product.id][:title] = product.title
    @order_items[product.id][:description] = product.description
    @order_items[product.id][:price] = product.price
    @order_items[product.id][:image] = product.image.key
    @order_items[product.id][:quantity] = item.quantity
  end

  def handle_order
    order = Order.find(params[:id])
    order.update_attribute(:handled_by_admin, true)

    redirect_to orders_path
  end

  def find_order_price
    price = 0
    @order_items.each do |id, product|
      prod = Product.find(id)
      price += prod.price * product[:quantity]
    end
    @price = price
  end
end
