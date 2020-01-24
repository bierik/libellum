class DropTaskContainers < ActiveRecord::Migration[6.0]
  def change
    remove_belongs_to :tasks, :task_container, foreign_key: true
    drop_table :task_containers
  end
end
