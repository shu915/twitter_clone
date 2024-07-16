require 'rails_helper'

RSpec.describe "ユーザーの新規登録のシステムスペック", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "情報が揃っているので" do
    scenario "ユーザーが新規登録できる" do

      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(1)
      expect(User.last.email).to eq("chukichi915@gmail.com")
      expect(page).to have_current_path(new_user_session_path)

    end
  end

  context "メールアドレスがないので" do
    scenario "ユーザー登録できない" do

      visit new_user_registration_path
      fill_in "メールアドレス", with: ""
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("メールアドレスを入力してください")
    end
  end



  context "すでに同じメールで登録しているので" do
    let(:user){ FactoryBot.create(:user) }

    scenario "登録失敗する" do

      visit new_user_registration_path
      fill_in "メールアドレス", with: user.email
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(1)
      expect(page).to have_content("メールアドレスはすでに存在します")
    end
  end

  context "アカウントネームがないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: ""
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("アカウントネームを入力してください")
    end
  end

  context "すでに同じアカウントネームで登録しているので" do
    let(:user){ FactoryBot.create(:user) }

    scenario "登録失敗する" do

      visit new_user_registration_path
      fill_in "メールアドレス", with: "shu915.web.creation@gmail.com"
      fill_in "アカウントネーム", with: user.account_name
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(1)
      expect(page).to have_content("アカウントネームはすでに存在します")
    end
  end

  context "アカウントネームが長すぎるので" do
    scenario "登録できない" do

      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "a" * 21
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("アカウントネームは20文字以内で入力してください")
    end
  end

  context "ディスプレイネームがないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: ""
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("ディスプレイネームを入力してください")
    end
  end

  context "ディスプレイネームが長過ぎるので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "a" * 21
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("ディスプレイネームは20文字以内で入力してください")
    end
  end

  context "電話番号がないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: ""
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("電話番号を入力してください")
    end
  end

  context "電話番号がないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "abc"
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("話番号は数値で入力してください")
    end
  end

  context "電話番号がないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0" * 21
      fill_in "誕生日(必須)", with: "2000-01-01"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("電話番号は20文字以内で入力してください")
    end
  end

  context "誕生日がないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: ""
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("誕生日を入力してください")
    end
  end

  context "誕生日が13月なので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-13-1"
      fill_in "パスワード", with: "12345678"
      fill_in "パスワード（確認用）", with: "12345678"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("誕生日を入力してください")
    end
  end

  context "パスワードがないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-12-1"
      fill_in "パスワード", with: ""
      fill_in "パスワード（確認用）", with: ""
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("スワードを入力してください")
    end
  end

  context "パスワードが短すぎる" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-12-1"
      fill_in "パスワード", with: "12345"
      fill_in "パスワード（確認用）", with: "12345"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("パスワードは6文字以上で入力してください")
    end
  end

  context "パスワードが一致してないので" do
    scenario "登録できない" do
      visit new_user_registration_path
      fill_in "メールアドレス", with: "chukichi915@gmail.com"
      fill_in "アカウントネーム", with: "shu915"
      fill_in "ディスプレイネーム", with: "shu915"
      fill_in "電話番号(必須)", with: "0000000000"
      fill_in "誕生日(必須)", with: "2000-12-1"
      fill_in "パスワード", with: "11111111"
      fill_in "パスワード（確認用）", with: "22222222"
      click_button "登録する"

      expect(User.count).to eq(0)
      expect(page).to have_content("パスワード（確認用）とパスワードの入力が一致しません")
    end
  end

end
