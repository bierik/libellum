class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :number
      t.string :place
      t.string :zip
      t.integer :distance
      t.integer :route_flat

      t.timestamps

    end

    add_foreign_key :tasks, :customers
  end
end
