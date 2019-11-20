class AddYearAndMonthToInvoices < ActiveRecord::Migration[5.2]
  def change
    change_table :invoices do |t|
      t.remove :date
      t.string   :year
      t.string   :month
    end
  end
end
