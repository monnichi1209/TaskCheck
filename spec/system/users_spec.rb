require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーの新規登録ができる場合' do
      it '新規登録が完了されたメッセージが表示される' do
        visit new_user_path
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'Create User'
        expect(current_path).to eq tasks_path
        expect(page).to have_content 'Successfully signed up!'
      end
    end

    context 'ログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq login_path
      end
    end
  end

  context 'ユーザがログイン画面からログインした場合' do
    before do
      @user = FactoryBot.create(:user)
    end
  
    it 'ログインに成功する' do
      visit login_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Submit'
      expect(current_path).to eq tasks_path
    end
  
    it '自分の詳細画面(マイページ)に飛べること' do
      visit login_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Submit'
      visit user_path(@user)
      expect(current_path).to eq user_path(@user)
    end

    context '一般ユーザが他人の詳細画面に飛ぶと' do
      before do
        visit login_path
        fill_in 'email', with: @user.email
        fill_in 'password', with: @user.password
        click_button 'Submit'
      end
    end
  
    it 'タスク一覧画面に遷移する' do
      other_user = FactoryBot.create(:user)
      visit user_path(other_user)
      expect(current_path).to eq login_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      click_button 'Submit'
      expect(current_path).to eq tasks_path
    end
    
    it 'ログアウトができること' do
      user = FactoryBot.create(:user)
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Submit'
      click_link 'Logout'
      expect(page).to have_content 'Logged out'
    end
    

    end
  end
  
