class AddTitleToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :title, :string
  end
end
