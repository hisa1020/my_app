require 'rails_helper'

RSpec.feature "Users::Profile_Edit", type: :feature do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    visit users_profile_edit_path
  end

  describe "user_nav内のリンクのテスト" do
    context ".user-nav-pc内のリンクのテスト" do
      scenario "プロフィールに移動" do
        within('.user-nav-pc') do
          click_link 'プロフィール'
          expect(current_path).to eq users_profile_path
        end
      end
    end

    context ".user-nav-mobile内のリンクのテスト" do
      scenario "プロフィールに移動" do
        within('.user-nav-mobile') do
          click_link 'プロフィール'
          expect(current_path).to eq users_profile_path
        end
      end
    end
  end

  scenario "変更前のユーザー情報を表示" do
    expect(page).to have_field("name", with: @user.name)
    expect(page).to have_field("introduction", with: @user.introduction)
  end

  context "変更なしでプロフィールを更新する場合" do
    scenario "元のユーザー情報を表示" do
      click_button 'プロフィールを更新'
      expect(current_path).to eq users_profile_path
      expect(page).to have_content @user.name
      expect(page).to have_content @user.introduction
    end
  end

  context "ユーザー名を更新する場合" do
    scenario "新しいユーザー名を表示" do
      fill_in "name", with: "new-name"
      click_button 'プロフィールを更新'
      expect(current_path).to eq users_profile_path
      expect(page).to have_content("プロフィールの更新に成功しました。")
      expect(page).to have_content("new-name")
      expect(page).to have_content @user.introduction
    end
  end

  context "ユーザー名が空白の場合" do
    scenario "ユーザー名更新できず(空白)" do
      fill_in "name", with: ""
      click_button 'プロフィールを更新'
      expect(page).to have_content("ユーザー名を入力してください")
      expect(page).to have_content("ユーザー名は3文字以上で入力してください")
    end
  end

  context "ユーザー名が3文字未満の場合" do
    scenario "ユーザー名更新できず(字数不足)" do
      fill_in "name", with: "n"
      click_button 'プロフィールを更新'
      expect(page).not_to have_content("ユーザー名を入力してください")
      expect(page).to have_content("ユーザー名は3文字以上で入力してください")
    end
  end

  context "自己紹介文を更新" do
    scenario "新しい自己紹介文を表示" do
      fill_in "introduction", with: "よろしくお願いします。"
      click_button 'プロフィールを更新'
      expect(current_path).to eq users_profile_path
      expect(page).to have_content("プロフィールの更新に成功しました。")
      expect(page).to have_content @user.name
      expect(page).to have_content("よろしくお願いします。")
    end
  end

  context "自己紹介文が空白の場合" do
    scenario "ユーザー名更新できず(空白)" do
      fill_in "introduction", with: ""
      click_button 'プロフィールを更新'
      expect(page).to have_content("自己紹介文を入力してください")
      expect(page).to have_content("自己紹介文は10文字以上で入力してください")
    end
  end

  context "自己紹介文が10文字未満の場合" do
    scenario "ユーザー名更新できず(字数不足)" do
      fill_in "introduction", with: "よろしく"
      click_button 'プロフィールを更新'
      expect(page).not_to have_content("自己紹介文を入力してください")
      expect(page).to have_content("自己紹介文は10文字以上で入力してください")
    end
  end

  context "自己紹介文が30文字以上の場合" do
    scenario "ユーザー名更新できず(字数オーバー)" do
      fill_in "introduction", with: "自己紹介文は10文字以上30文字以内になるようバリテーションをかけています。"
      click_button 'プロフィールを更新'
      expect(page).not_to have_content("自己紹介文を入力してください")
      expect(page).to have_content("自己紹介文は30文字以内で入力してください")
    end
  end
end