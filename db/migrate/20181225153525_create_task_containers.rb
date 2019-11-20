class CreateTaskContainers < ActiveRecord::Migration[5.2]
  def change
    create_table :task_containers do |t|

      t.timestamps
    end
  end
end
