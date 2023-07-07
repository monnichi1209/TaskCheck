class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  STATUS = ['未着手', '着手中', '完了'].freeze

  validates :status, inclusion: { in: Task::STATUS }

  scope :search_by_name, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :search_by_status, -> (status) { where(status: status) if status.present? }
  scope :sort_by_expired, -> (sort_expired) { order(expired_at: :desc) if sort_expired.present? }
end
