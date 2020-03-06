json.extract! task, :id, :title, :rrule, :duration, :created_at, :updated_at
json.url task_path(task, format: :json)
json.customer task.customer.full_name
json.color task.customer.color
json.brightColor task.customer.bright_color?
