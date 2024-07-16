require 'rails_helper'

RSpec.describe "ログインのシステムスペック", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user){ FactoryBot.create(:user) }

  context "メールアドレスとパスワードが正常なので" do
    scenario "ログインできる" do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"


      expect(page).to have_content("ホーム")
    end
  end

  context "メールアドレスがないので" do
    scenario "ログインできない" do
      visit new_user_session_path
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: user.password
      click_button "ログイン"


      expect(page).to have_content("無効なメールアドレスまたはパスワードです")
    end
  end

  context "パスワードがないので" do
    scenario "ログインできない" do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: ""
      click_button "ログイン"


      expect(page).to have_content("メールアドレスまたはパスワードが無効です")
    end
  end

  context "メールとパスワードが一致しないので" do
    scenario "ログインできない" do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: "zzzzzzz"
      click_button "ログイン"


      expect(page).to have_content("無効なメールアドレスまたはパスワードです。")
    end
  end




end
