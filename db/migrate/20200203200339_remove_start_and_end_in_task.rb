class RemoveStartAndEndInTask < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :start, :datetime
    remove_column :tasks, :end, :datetime
    add_column :tasks, :rrule, :string
    add_column :tasks, :duration, :string
  end
end
