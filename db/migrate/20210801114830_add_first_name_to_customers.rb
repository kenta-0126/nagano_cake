class AddFirstNameToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :last__name, :string
    add_column :customers, :first_name, :string
    add_column :customers, :last_name_kana, :string
    add_column :customers, :first_name_kana, :string
    add_column :customers, :postal_code, :string
    add_column :customers, :address, :string
    add_column :customers, :telephone_code, :string
    add_column :customers, :is_active, :boolean
  end
end
