class AddPricePerHourToCustomer < ActiveRecord::Migration[5.2]
  def change
    change_table :customers do |t|
      t.numeric :price_per_hour, default: 50
    end
  end
end
