class AddFullDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bank, :string
    add_column :users, :bank_account, :integer
    add_column :users, :phone, :integer
  end
end
