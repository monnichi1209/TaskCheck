require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: 'New Task'
        fill_in 'task[description]', with: 'New Task Content'
        fill_in 'task[expired_at]', with: DateTime.now
        find('.actions input[type="submit"]').click

  
        expect(current_path).to eq task_path(Task.last)
        expect(page).to have_content 'New Task'
        expect(page).to have_content 'New Task Content'
      end
    end
  end
  
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
      FactoryBot.create(:task, name: 'task')
      visit tasks_path
      expect(page).to have_content 'task'
      end
    end

  context '終了期限でソートするというリンクを押した場合' do
    it '終了期限の降順に並び替えられたタスク一覧が表示される' do
      task1 = FactoryBot.create(:task, name: 'task1', expired_at: DateTime.now + 1.day)
      task2 = FactoryBot.create(:task, name: 'task2', expired_at: DateTime.now + 2.days)
      
      visit tasks_path(sort_expired: "true")
      tasks = all('.task_row') 

      expect(tasks[0]).to have_content 'task2'
      expect(tasks[1]).to have_content 'task1'
    end
  end
end
  
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, name: 'Task Title', description: 'Task Content')
  
        visit task_path(task)
  
        expect(page).to have_content 'Task Title'
        expect(page).to have_content 'Task Content'
      end
    end
  end
end