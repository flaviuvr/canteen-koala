class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :cart, null: false, foreign_key: true
      t.boolean :handled_by_admin, default: false

      t.timestamps
    end
  end
end
