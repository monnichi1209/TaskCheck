class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  STATUS = ['未着手', '着手中', '完了'].freeze

  validates :status, inclusion: { in: Task::STATUS }
end
