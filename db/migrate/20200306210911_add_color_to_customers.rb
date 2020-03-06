class AddColorToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :color, :string, unique: true, null: false, default: '#000000'
  end
end
