class AddTasksToTaskContainer < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :task_container, foreign_key: true
  end
end
