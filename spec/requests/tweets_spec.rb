require 'rails_helper'

RSpec.describe "ログインして、ツイートをするリクエストスペック", type: :request do
  describe "ツイートができるかテストする" do
    let(:user){ FactoryBot.create(:user) }

    context "ツイートの中身が適切なので" do
      it "正常にツイートできる" do
        sign_in user
        image = fixture_file_upload('spec/image/image.jpg','image.jpg')
        expect {
          post tweets_path, params: { tweet: { content: "content", image: image } }
      }.to change(Tweet, :count)
        expect(response).to redirect_to(root_path)
      end
    end

    context "ツイートが空なので" do
      it "ツイートのpresenceのバリデーションに引っかかる" do
        sign_in user
        expect {
          post tweets_path, params: { tweet: { content: "" } }
        }.not_to change(Tweet, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("ツイートを入力してください") # レスポンスの内容を確認
      end
    end

    context "ツイートが141文字なので" do
      it "ツイートのlengthのバリデーションに引っかかる" do
        sign_in user
        expect {
          post tweets_path, params: { tweet: { content: "a" * 141 } }
        }.not_to change(Tweet, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("ツイートは140文字以内で入力してください") # レスポンスの内容を確認
      end
    end

    context "画像の拡張子を間違えたら" do
      it "画像の拡張子のバリデーションに引っかかる" do
        sign_in user
        not_image = fixture_file_upload('spec/image/file.txt', 'file.text')
        expect {
          post tweets_path, params: { tweet: { content: "content", image: not_image } }
        }.not_to change(Tweet, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("ツイート画像はpng, jpeg, jpg, webpのいずれかにしてください") # レスポンスの内容を確認
      end
    end

    context "画像のサイズが5kbを超えている" do
      it "画像のサイズのバリデーションに引っかかる" do
        sign_in user
        image = fixture_file_upload('spec/image/10MB.png', '10MB.png')
        expect {
          post tweets_path, params: { tweet: { content: "content", image: image } }
        }.not_to change(Tweet, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("ツイート画像ファイル サイズは 5MB 未満にする必要があります") # レスポンスの内容を確認
      end
    end

  end
end
