class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.date :date

      t.timestamps

      t.integer :customer_id
    end
  end
end
