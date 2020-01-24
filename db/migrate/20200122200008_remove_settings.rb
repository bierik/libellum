class RemoveSettings < ActiveRecord::Migration[6.0]
  def change
    drop_table :settings
  end
end
