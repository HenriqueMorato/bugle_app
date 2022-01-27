# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    name { Faker::Educator.course_name }
    user
    course

    after(:build) do |content|
      content.file.attach(
        io: File.open(
          Rails.root.join('spec/fixtures/files/dramatic_chipmunk.mp4')
        ),
        filename: 'dramatic_chipmunk.mp4',
        content_type: 'video/mp4'
      )
    end
  end
end
