class CreateGlasses < ActiveRecord::Migration[7.1]
  def change
    create_table :glasses do |t|
      t.references :frame, null: false, foreign_key: true
      t.references :len, null: false, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
