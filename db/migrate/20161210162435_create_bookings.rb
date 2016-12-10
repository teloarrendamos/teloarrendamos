class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.references :listing, foreign_key: true
      t.references :order
      t.date :start_date
      t.date :end_date
      t.integer :subtotal

      t.timestamps
    end
  end
end
