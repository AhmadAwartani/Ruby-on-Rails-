class CreateLens < ActiveRecord::Migration[7.1]
  def change
    create_table :lens do |t|
      t.string :colour
      t.text :description
      t.integer :prescription_type
      t.integer :lens_type
      t.integer :stock
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :currency, null: false
      t.timestamps
      end 

      # to add a unique index of the price and currency 
      add_index : lens, [:price, :currency], unique: true
  end
end
