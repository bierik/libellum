class AddAdditionalInformationToOrganization < ActiveRecord::Migration[6.0]
  def up
    change_table :organizations do |t|
      t.string :company
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :number
      t.string :zip
      t.string :place
      t.float :price_per_hour
      t.integer :report_invoice_round, default: 5.minutes
    end

    Organization.update_all(
      first_name: 'Vorname',
      last_name: 'Nachname',
      street: 'Strasse',
      zip: 'PLZ',
      place: 'Ort',
      price_per_hour: 50,
    )

    [:first_name, :last_name, :street, :zip, :place, :price_per_hour].each do |column|
      change_column_null :organizations, column, true
    end
  end

  def down
    change_table :organizations do |t|
      t.remove :company, :first_name, :last_name, :street, :number, :zip, :place, :price_per_hour, :report_invoice_round
    end
  end
end
