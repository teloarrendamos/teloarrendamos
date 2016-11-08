class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.float :latitude
      t.float :longitude
      t.string :address_detail
      t.string :address_title
      t.string :description
      t.text :details
      t.references :category, foreign_key: true
      t.references :company, foreign_key: true
      t.integer :hourly_rate
      t.integer :daily_rate
      t.integer :weekly_rate
      t.integer :monthly_rate
      t.integer :deposit

      t.timestamps
    end
  end
end
