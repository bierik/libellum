class AddInvoiceCustomerRelation < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :invoices, :customers
  end
end
