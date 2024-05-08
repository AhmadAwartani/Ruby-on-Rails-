class CreateFrames < ActiveRecord::Migration[7.1]
  def change
    create_table :frames do |t|
      t.string :name
      t.text :description
      t.integer :status
      t.integer :stock
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :currency, null: false
      t.timestamps
      end 

      # to add a unique index of the price and currency 
      add_index : frames, [:price, :currency], unique: true
  end
end
