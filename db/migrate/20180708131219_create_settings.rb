class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :firstname
      t.string :lastname
      t.string :street
      t.string :number
      t.string :place
      t.string :zip
      t.string :maps_api_key
    end
  end
end
