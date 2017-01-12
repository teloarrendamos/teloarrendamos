class AddFieldsToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :address, :string
    add_column :listings, :latitude, :decimal, precision: 10, scale: 6
    add_column :listings, :longitude, :decimal, precision: 10, scale: 6
  end
end
