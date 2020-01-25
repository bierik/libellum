class AddUsedDateToFlats < ActiveRecord::Migration[6.0]
  def change
    add_column :flats, :used_date, :date, null: false
  end
end
