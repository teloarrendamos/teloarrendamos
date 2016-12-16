class ChangeOrderToBigDecimal < ActiveRecord::Migration[5.0]
  def self.up
    change_column :orders, :total, :decimal, precision: 12, scale: 2
  end
 
  def self.down
    change_column :orders, :total, :integer
  end
end
