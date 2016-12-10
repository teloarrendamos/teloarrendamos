class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :orderable, polymorphic: true, index: true
      t.integer :total

      t.timestamps
    end
  end
end
