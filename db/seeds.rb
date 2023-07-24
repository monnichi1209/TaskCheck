# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ユーザーとラベルの初期データ
User.find_or_create_by!(email: 'initial_user@example.com') do |user|
  user.name = '初期ユーザー'
  user.password = '12345678'
  user.password_confirmation = '12345678'
end

labels = ['ラベル1', 'ラベル2', 'ラベル3']
labels.each do |label|
  Label.find_or_create_by!(name: label)
end

# 追加のユーザー、タスク、ラベルのデータ
10.times do |i|
  user = User.find_or_create_by!(email: "user#{i}@example.com") do |user|
    user.name = "User #{i}"
    user.password = 'password'
    user.password_confirmation = 'password'
  end

  Task.create!(name: "Task #{i}", description: "This is task #{i}", expired_at: DateTime.now + i.days, user: user, status: Task::STATUS.sample, priority: Task::PRIORITY.sample)

  Label.find_or_create_by!(name: "Label #{i}")
end