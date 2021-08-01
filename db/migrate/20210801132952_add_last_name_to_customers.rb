class AddLastNameToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :last_name, :string
    add_column :customers, :telephone_number, :string
  end
end
