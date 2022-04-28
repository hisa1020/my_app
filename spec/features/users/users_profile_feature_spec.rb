require 'rails_helper'
require 'spec_helper'

RSpec.feature "Users::Profile", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:posts) { FactoryBot.create_list(:post, rand(10), user_id: user.id) }
  let!(:questions) { FactoryBot.create_list(:question, rand(10), user_id: user.id) }
  let!(:comments) { FactoryBot.create_list(:comment, rand(10), user_id: user.id) }
  let!(:q_comments) { FactoryBot.create_list(:q_comment, rand(10), user_id: user.id) }
  let!(:favorites) { FactoryBot.create_list(:favorite, rand(10), user_id: user.id) }
  let!(:q_favorites) { FactoryBot.create_list(:q_favorite, rand(10), user_id: user.id) }

  before do
    sign_in user
    visit users_profile_path
  end

  scenario "ロゴのクリックでトップページに移動" do
    find('.header-logo-link').click
    expect(current_path).to eq root_path
  end

  describe "user_nav内のリンクが正常に作動する" do
    context ".user-nav-pc内のリンク" do
      scenario "ユーザー投稿一覧に移動" do
        within('.user-nav-pc') do
          click_link '投稿をみる'
          expect(current_path).to eq users_posts_path
        end
      end

      scenario "ユーザー質問一覧に移動" do
        within('.user-nav-pc') do
          click_link '質問をみる'
          expect(current_path).to eq users_questions_path
        end
      end

      scenario "お気に入りに移動" do
        within('.user-nav-pc') do
          click_link 'お気に入りをみる'
          expect(current_path).to eq users_favorite_posts_path
        end
      end
    end

    context ".user-nav-mobile内のリンク" do
      scenario "ユーザー投稿一覧に移動" do
        within('.user-nav-mobile') do
          click_link '投稿をみる'
          expect(current_path).to eq users_posts_path
        end
      end

      scenario "ユーザー質問一覧に移動" do
        within('.user-nav-mobile') do
          click_link '質問をみる'
          expect(current_path).to eq users_questions_path
        end
      end

      scenario "お気に入りに移動" do
        within('.user-nav-mobile') do
          click_link 'お気に入りをみる'
          expect(current_path).to eq users_favorite_posts_path
        end
      end
    end
  end

  scenario "ユーザー情報の表示" do
    within('.user-view-box') do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
      expect(page).to have_selector("img[src$='#{user.user_icon.identifier}']")
      expect(page).to have_content user.posts_counts
      expect(page).to have_content user.comments_counts
      expect(page).to have_content user.favorites_counts
    end
  end

  scenario "プロフィール編集に移動" do
    click_link 'プロフィールを編集'
    expect(current_path).to eq users_profile_edit_path
  end

  scenario "パスワード変更に移動" do
    click_link 'パスワードを変更'
    expect(current_path).to eq edit_user_registration_path
  end
end
