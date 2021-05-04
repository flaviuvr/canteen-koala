class Product < ApplicationRecord
  has_one_attached :image

  validates_presence_of :title, :description, :price, :image
end
