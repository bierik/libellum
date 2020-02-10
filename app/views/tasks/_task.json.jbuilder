json.extract! task, :id, :title, :rrule, :duration, :created_at, :updated_at
json.url customer_task_path(@customer, task, format: :json)
