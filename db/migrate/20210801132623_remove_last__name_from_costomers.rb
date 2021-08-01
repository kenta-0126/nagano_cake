class RemoveLastNameFromCostomers < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :last__name, :string
    remove_column :customers, :telephone_code, :string
  end
end
