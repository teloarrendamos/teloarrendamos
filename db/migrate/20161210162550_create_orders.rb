class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :orderable, polymorphic: true
      t.integer :total

      t.timestamps
    end

    add_index :orders, [:orderable_type, :orderable_id]
  end
end
