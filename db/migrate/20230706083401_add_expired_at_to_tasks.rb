class AddExpiredAtToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :expired_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
