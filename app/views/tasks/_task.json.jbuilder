json.extract! task, :id, :title, :rrule, :duration, :created_at, :updated_at
json.url task_path(task, format: :json)
