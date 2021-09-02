class Cart < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :cart_items
  has_one :order
end
