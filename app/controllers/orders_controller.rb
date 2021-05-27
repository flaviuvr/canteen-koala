class OrdersController < ApplicationController
  before_action :find_user_orders, only: %i[index show]
  before_action :find_order_items, only: :show

  def index
    find_all_orders if current_user.admin?
  end

  def show; end

  def find_user_orders
    @orders = {}
    order_carts = Cart.where('user_id = ? AND placed_order = ?', current_user.id, true)

    order_carts.each do |cart|
      current_order = Order.where('cart_id = ?', cart.id).last
      @orders[current_order] = current_order.handled_by_admin
    end
  end

  def find_all_orders
    order_carts = Cart.where('placed_order = ?', true)

    order_carts.each do |cart|
      current_order = Order.where('cart_id = ?', cart.id).last
      @orders[current_order] = current_order.handled_by_admin
    end
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
end
