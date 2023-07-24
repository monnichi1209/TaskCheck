require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:labels) { FactoryBot.create_list(:label, 3) }

  describe '新規作成機能' do
    before do
      user = FactoryBot.create(:user)
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Submit'
    end
    
    context 'タスクを新規作成した場合' do
      it 'ラベルを複数選択ができる' do
        visit new_task_path
        fill_in 'task[name]', with: 'New Task'
        fill_in 'task[description]', with: 'New Task Content'
        fill_in 'task[expired_at]', with: DateTime.now
        check "task_label_ids_#{labels[0].id}"
        check "task_label_ids_#{labels[1].id}"
        select '未着手', from: 'task[status]' 
        select '高', from: 'task[priority]' 
        find('.actions input[type="submit"]').click

        expect(current_path).to eq task_path(Task.last)
        expect(page).to have_content 'New Task'
        expect(page).to have_content 'New Task Content'
        expect(page).to have_content '未着手' 
        expect(page).to have_content '高'

        task = Task.find_by(name: 'New Task')
        expect(task.labels).to include(labels[0], labels[1])
      end
    end


    describe '検索機能' do
      before do
        visit tasks_path
      end
  
      context 'ラベルで検索した場合' do
        it '選択したラベルを含むタスクが表示される' do
          select labels[0].name, from: 'label_id'
          click_on 'task_search'
          expect(page).to have_content 'New Task'
        end
      end
    end
  end
end