class ChangeDailyRateToBigdecimal < ActiveRecord::Migration[5.0]
  def self.up
    change_column :listings, :daily_rate, :decimal, precision: 12, scale: 2
  end
 
  def self.down
    change_column :listings, :daily_rate, :integer
  end
end
