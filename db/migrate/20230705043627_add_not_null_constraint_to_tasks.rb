class AddNotNullConstraintToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :name, false
    change_column_null :tasks, :description, false
  end
end
