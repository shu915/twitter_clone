# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    association :user
    content { 'ツイートです' }

    after(:build) do |tweet|
      tweet.image.attach(io: File.open('spec/image/image.jpg'), filename: 'image.jpg')
    end

    trait :empty_content do
      content { nil }
    end

    trait :empty_user do
      user { nil }
    end

    trait :not_image do
      after(:build) do |tweet|
        tweet.image.attach(io: File.open('spec/image/file.txt'), filename: 'file.txt')
      end
    end
  end
end
