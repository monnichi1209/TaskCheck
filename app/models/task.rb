class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  STATUS = ['未着手', '着手中', '完了'].freeze

  PRIORITY = ['高', '中', '低'].freeze
  validates :priority, inclusion: { in: Task::PRIORITY }
  validates :status, inclusion: { in: Task::STATUS }

  scope :search_by_name, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :search_by_status, -> (status) { where(status: status) if status.present? }
  scope :sort_by_expired, -> (sort_expired) { order(expired_at: :desc) if sort_expired.present? }
  scope :sort_by_priority, -> (sort_priority) { order(priority: :desc) if sort_priority.present? }
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

end
