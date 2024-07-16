# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  tel                    :string           not null
#  birthday               :date             not null
#  account_name           :string           not null
#  display_name           :string           not null
#  location               :string           default("非公開")
#  url                    :string
#  self_intro             :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザーの新規作成するとき" do
    context "入力項目が揃っているので" do
      let(:user){ FactoryBot.create(:user) }

      it "ユーザーが作れる" do
        expect(user).to be_valid
      end
    end

    context "メールをnilにして" do
      let(:user){ FactoryBot.build(:user, :empty_email) }

      it "emailのバリデーションに引っかかる" do
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
    end

    context "account_nameをnilにして" do
      let(:user){ FactoryBot.build(:user, :empty_account_name) }

      it "account_nameのバリデーションに引っかかる" do
        user.valid?
        expect(user.errors[:account_name]).to include("を入力してください")
      end
    end

  end
end
