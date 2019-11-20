class UseDateForInvoices < ActiveRecord::Migration[5.2]
  def change
    change_table :invoices do |t|
      t.date :date
      t.remove   :year
      t.remove   :month
    end
  end
end
