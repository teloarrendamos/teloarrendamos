class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.references :listing, foreign_key: true
      t.references :order, foreign_key: true
      t.decimal :unit_price, precision: 12, scale: 3
      t.decimal :total_price, precision: 12, scale: 3
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
