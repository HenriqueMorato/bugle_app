# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }

    trait :admin do
      role { 'admin' }
    end
  end
end
