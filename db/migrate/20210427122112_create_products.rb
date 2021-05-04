class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end
