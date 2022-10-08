class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :quantity
      t.integer :amount
      t.timestamps
    end
  end
end
