class AddEndDateToTask < ActiveRecord::Migration[5.2]
  def change
    change_table :tasks do |t|
      t.datetime :end
      t.rename :date, :start
    end
  end
end
