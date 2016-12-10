class ChangeListingToPolymorphic < ActiveRecord::Migration[5.0]
  def change
    remove_column :listings, :company_id

    add_column :listings, :postable_id, :integer
    add_column :listings, :postable_type, :string

    add_index :listings, [:postable_type, :postable_id]
  end
end
