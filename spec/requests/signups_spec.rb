require 'rails_helper'

RSpec.describe "ユーザー新規登録のリクエストスペック", type: :request do
  describe "ユーザーを新規登録しようとすると" do
    let(:user_attributes) { FactoryBot.attributes_for(:user) }
    context "すべての情報が揃っているので" do

      it "ユーザーを登録できる" do
        expect {
          post user_registration_path, params: { user: user_attributes }
        }.to change(User, :count).by(1)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "emailがないので、" do

      it "emailのpresenceのバリデーションに引っかかる" do
        user_attributes[:email] = nil
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("メールアドレスを入力してください")
       end
    end

    context "emailのフォーマットが間違っているので" do

      it "emailのフォーマットのバリデーションに引っかかる" do
        user_attributes[:email] = "https://abc.com"
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("メールアドレスは不正な値です")
       end
    end

    context "すでに同じメールがあるので" do
      let!(:user){ FactoryBot.create(:user) }

      it "mailのuniqenessのバリデーションに引っかかる" do
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("メールアドレスはすでに存在します")
      end
    end

    context "account_nameが空欄なので" do

      it "account_nameのpreseceのバリデーションに引っかかる" do
        user_attributes[:account_name] = ""
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("アカウントネームを入力してください")
      end
    end

    context "account_nameが21文字なので" do

      it "account_nameのlengthのバリデーションに引っかかる" do
        user_attributes[:account_name] = "a" * 21
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("アカウントネームは20文字以内で入力してください")
      end
    end

    context "すでに同じアカウントネームがあるので" do
      let!(:user){ FactoryBot.create(:user) }

      it "account_nameのuniqenessのバリデーションに引っかかる" do
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("アカウントネームはすでに存在します")
      end
    end

    context "display_nameがないので" do
      it "display_nameのpresenceのバリデーションに引っかかる" do
        user_attributes[:display_name] = ""
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("ディスプレイネームを入力してください")
      end
    end

    context "display_nameが21文字なので" do
      it "display_nameのlengthのバリデーションに引っかかる" do
        user_attributes[:display_name] = "a" * 21
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("ディスプレイネームは20文字以内で入力してください")
      end
    end

    context "telが存在しないので" do
      it "telのpreseceのバリデーションに引っかかる" do
        user_attributes[:tel] = ""
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("電話番号を入力してください")
      end
    end

    context "telが21文字以上なので" do
      it "telのlengthのバリデーションに引っかかる" do
        user_attributes[:tel] = "0" * 21
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("電話番号は20文字以内で入力してください")
      end
    end

    context "telが整数だけではないので" do
      it "telのnumericalityのバリデーションに引っかかる" do
        user_attributes[:tel] = "000000000a"
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("電話番号は数値で入力してください")
      end
    end

    context "誕生日が存在しないので" do
      it "誕生日のpreseceのバリデーションに引っかかる" do
        user_attributes[:birthday] = ""
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("誕生日を入力してください")
      end
    end

    context "誕生日の日付が間違っているので" do
      it "誕生日のformatのバリデーションに引っかかる" do
        user_attributes[:birthday] = "20001301"
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("誕生日を入力してください")
      end
    end

    context "パスワードが空欄なので" do
      it "パスワードのpreseceのバリデーションに引っかかる" do
        user_attributes[:password] = nil
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("パスワードを入力してください")
      end
    end

    context "パスワードが5文字なので" do
      it "パスワードのlengthのバリデーションに引っかかる" do
        user_attributes[:password] = "a" * 5
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("パスワードは6文字以上で入力してください")
      end
    end

    context "確認用パスワードと一致しないので" do
      it "パスワードの不一致によって、バリデーションに引っかかる" do
        user_attributes[:password] = "a" * 6
        user_attributes[:password_confirmation] = "b" * 6
        post user_registration_path, params: { user: user_attributes }
        expect(response).to have_http_status "422"
        expect(response.body).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end

  end
end
