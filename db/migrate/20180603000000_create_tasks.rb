class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.datetime :date

      t.timestamps

      t.integer :customer_id

    end

    add_foreign_key :flats, :tasks
    add_foreign_key :reports, :tasks
  end
end
