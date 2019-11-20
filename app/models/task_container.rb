class TaskContainer < ApplicationRecord
  has_many :tasks, dependent: :destroy

  def following(from)
    tasks.where("start >= ?", from)
  end
end
