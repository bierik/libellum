class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps

      t.integer :task_id
    end
  end
end
