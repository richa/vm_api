class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :cost
      t.integer :amount_available, default: 0
      t.integer :seller_id
      t.timestamps
    end
  end
end
