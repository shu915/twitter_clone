require 'rails_helper'

RSpec.describe "Tweets", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user){ FactoryBot.create(:user) }


  context "条件が揃っているので" do
    scenario "ツイートできる" do
      sign_in user
      visit root_path
      fill_in "tweet_content", with: "システムテストのツイートです。"
      attach_file "画像をアップロード", "spec/image/image.jpg"
      click_button "ツイートする"

      expect(page).to have_content("システムテストのツイートです。")
      expect(page).to have_content("ツイートを投稿しました。")
      expect(Tweet.count).to eq(1)
    end
  end

  context "ツイートが空なので" do
    scenario "ツイートできない" do
      sign_in user
      visit root_path
      fill_in "tweet_content", with: ""
      click_button "ツイートする"

      expect(page).to have_content("ツイートを入力してください")
      expect(Tweet.count).to eq(0)
    end
  end

  context "ツイートが141字なので" do
    scenario "ツイートできない" do
      sign_in user
      visit root_path
      fill_in "tweet_content", with: "a" * 141
      click_button "ツイートする"

      expect(page).to have_content("ツイートは140文字以内で入力してください")
      expect(Tweet.count).to eq(0)
    end
  end

  context "画像ファイルの拡張子がおかしいので" do
    scenario "ツイートできない" do
      sign_in user
      visit root_path
      fill_in "tweet_content", with: "システムテストのツイートです。"
      attach_file "画像をアップロード", "spec/image/file.txt"
      click_button "ツイートする"

      expect(page).to have_content("ツイート画像はpng, jpeg, jpg, webpのいずれかにしてください")
      expect(Tweet.count).to eq(0)
    end
  end

  context "画像ファイルのサイズが大きすぎるので" do
    scenario "ツイートできない" do
      sign_in user
      visit root_path
      fill_in "tweet_content", with: "システムテストのツイートです。"
      attach_file "画像をアップロード", "spec/image/10MB.png"
      click_button "ツイートする"

      expect(page).to have_content("ツイート画像ファイル サイズは 5MB 未満にする必要があります")
      expect(Tweet.count).to eq(0)
    end
  end


end
