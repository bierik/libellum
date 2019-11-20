class RemoveNumberFromInvoice < ActiveRecord::Migration[5.2]
  def change
    change_table :invoices do |t|
      t.remove :number
    end
  end
end
