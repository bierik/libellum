class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :handle, unique: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
