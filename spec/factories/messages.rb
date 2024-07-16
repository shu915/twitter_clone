# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    association :user
    room { Room.create }
    content { 'DMの中身' }

    trait :empty_content do
      content { nil }
    end
  end
end
