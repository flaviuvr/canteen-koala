class AddPlacedToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :placed_order, :boolean, default: false
  end
end
