# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'chukichi915@gmail.com' }
    account_name { 'shu915' }
    display_name { 'shu915' }
    tel { '00000000000' }
    birthday { '2000-10-10' }
    password { 'password1' }
    confirmed_at { Time.zone.now }

    trait :empty_email do
      email { nil }
    end

    trait :empty_account_name do
      account_name { nil }
    end
  end
end
