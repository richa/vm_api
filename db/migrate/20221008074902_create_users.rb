class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.integer :deposit, default: 0
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
