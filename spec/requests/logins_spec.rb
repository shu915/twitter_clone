# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '登録したあと、そのユーザーでログインするリクエストスペック', type: :request do
  describe '登録して、ログイン' do
    let!(:user) { FactoryBot.create(:user) }

    context '入力情報が正しいので' do
      it '正常にログインできる' do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
        expect(response).to have_http_status 303
        expect(response).to redirect_to root_path
      end
    end

    context 'メールが空なので' do
      it 'メールのバリデーションに弾かれる' do
        post user_session_path, params: { user: { email: nil, password: user.password } }
        expect(response).to have_http_status 422
      end
    end

    context 'パスワードが空なので' do
      it 'パスワードのバリデーションに弾かれる' do
        post user_session_path, params: { user: { email: user.email, password: nil } }
        expect(response).to have_http_status 422
      end
    end

    context 'メールとパスワードが一致しない' do
      it 'バリデーションに弾かれる' do
        post user_session_path, params: { user: { email: user.email, password: 'password2' } }
        expect(response).to have_http_status 422
      end
    end
  end
end
