class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :check_logged_user, only: :add_to_cart
  before_action :find_current_cart, only: %i[add_to_cart remove_single_item_from_cart remove_product_from_cart]

  def index
    @products = Product.all

    redirect_to home_path
  end

  def new
    @product = Product.new
  end

  def show; end

  def edit; end

  def create
    @product = Product.new(product_params.except(:image))
    @product.image.attach(product_params[:image])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully added!' }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated!' }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    redirect_to home_path
  end

  def add_to_cart
    item = @current_cart.cart_items.find_by(product_id: params[:id])
    if item.nil?
      @current_cart.cart_items.create(cart_id: @current_cart.id, product_id: params[:id], quantity: 1)
    else
      item.update_attribute(:quantity, item.quantity + 1)
    end

    redirect_to carts_path
  end

  def remove_single_item_from_cart
    item = @current_cart.cart_items.find_by(product_id: params[:id])
    if item.quantity == 1
      remove_product_from_cart
    else
      item.update_attribute(:quantity, item.quantity - 1)

      redirect_to carts_path
    end
  end

  def remove_product_from_cart
    item = @current_cart.cart_items.find_by(product_id: params[:id])
    item.destroy

    redirect_to carts_path
  end



  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end
end
