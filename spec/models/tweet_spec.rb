# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'ツイートを作成するとき' do
    context 'userとcontentとimageがあるので' do
      let(:tweet) { FactoryBot.create(:tweet) }

      it '作成できる' do
        expect(tweet).to be_valid
      end
    end

    context 'コンテンツがないので' do
      let(:tweet) { FactoryBot.build(:tweet, :empty_content) }

      it 'contentのバリデーションに引っかかる' do
        tweet.valid?
        expect(tweet.errors[:content]).to include('を入力してください')
      end
    end

    context 'ユーザーがnilなので' do
      let(:tweet) { FactoryBot.build(:tweet, :empty_user) }

      it 'tweetが無効になる' do
        expect(tweet).to be_invalid
      end
    end

    context '添付ファイルが画像系ではないので' do
      let(:tweet) { FactoryBot.build(:tweet, :not_image) }

      it 'imageのバリデーションに引っかかる' do
        tweet.valid?
        expect(tweet.errors[:image]).to include('はpng, jpeg, jpg, webpのいずれかにしてください')
      end
    end
  end
end
