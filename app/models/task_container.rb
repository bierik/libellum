class TaskContainer < ApplicationRecord
  include Organizationable

  has_many :tasks, dependent: :destroy

  def following(from)
    tasks.where('start >= ?', from)
  end
end
