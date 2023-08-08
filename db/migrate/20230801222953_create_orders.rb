class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :shipping, null: false, default: 800
      t.integer :payment_status, null: false, default: 0
      t.integer :total_payment, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
