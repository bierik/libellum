class AddArchivedToInvoices < ActiveRecord::Migration[5.2]
  def change
    change_table :invoices do |t|
      t.boolean :archived
    end
  end
end
