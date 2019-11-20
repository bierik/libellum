class AddNumberToInvoice < ActiveRecord::Migration[5.2]
  def change
    change_table :invoices do |t|
      t.bigint   :number
    end
  end
end
