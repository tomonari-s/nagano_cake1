class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.references :customer,                 null: false, foreign_key: true
      t.string :delivery_address_name,        null: false
      t.string :delivery_address_postal_code, null: false
      t.string :delivery_address,             null: false
      t.integer :status,                      null: false, default: 0
      t.integer :payment_method,              null: false, default: 0
      t.integer :delivery_charge,             null: false
      t.integer :billing_amount,              null: false

      t.timestamps
    end
  end
end
