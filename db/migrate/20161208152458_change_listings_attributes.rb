class ChangeListingsAttributes < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :latitude, :float
    remove_column :listings, :longitude, :float
    remove_column :listings, :address_detail, :string
    remove_column :listings, :address_title, :string
    remove_column :listings, :details, :string
    add_column :listings, :title, :string
    add_column :listings, :region, :string
    remove_column :listings, :hourly_rate, :integer
    remove_column :listings, :weekly_rate, :integer
    remove_column :listings, :monthly_rate, :integer
    remove_column :listings, :deposit, :integer
    # change_column :listings, :description, :text
  end
end
