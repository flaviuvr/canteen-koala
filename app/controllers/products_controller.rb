class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
    redirect_to root_path
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
        format.html { redirect_to root_path, notice: 'Product was successfully added!' }
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
    redirect_to root_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end
end
