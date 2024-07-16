# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'ダイレクトメッセージを送ろうとすると' do
    context 'ユーザー、ルーム、コンテンツ揃っているので' do
      let(:message) { FactoryBot.create(:message) }

      it '正常に送れる' do
        expect(message).to be_valid
      end
    end

    context 'コンテンツがないので' do
      let(:message) { FactoryBot.build(:message, :empty_content) }

      it 'コンテンツのバリデーションに引っかかる' do
        message.valid?
        expect(message.errors[:content]).to include('を入力してください')
      end
    end
  end
end
