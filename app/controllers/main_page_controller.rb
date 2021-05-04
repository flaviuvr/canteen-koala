class MainPageController < ApplicationController
  def home
    @products = Product.all
  end
end
