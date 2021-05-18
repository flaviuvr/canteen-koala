class MainPageController < ApplicationController
  def home
    @products = Product.all
  end

  def landing; end
end
