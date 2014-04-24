class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :currency
      t.integer :amount
      t.boolean :paid, default: false
      t.boolean :refunded, default: false
      t.integer :customer_id

      t.timestamps
    end
  end
end
