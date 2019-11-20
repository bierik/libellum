class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.string :name
      t.float :price

      t.timestamps

      t.integer :task_id
    end
  end
end
