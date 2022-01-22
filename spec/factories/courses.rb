# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    title { Faker::Educator.course_name }
    description { Faker::Lorem.sentence }
  end
end
