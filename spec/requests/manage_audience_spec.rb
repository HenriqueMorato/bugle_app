# frozen_string_literal: true

require 'rails_helper'

describe 'Manage audiance' do
  let(:course) { create(:course) }
  context 'POST /api/v1/courses/:course_id/audiences' do
    it 'creates an audience to course' do
      user = create(:user)

      post "/api/v1/courses/#{course.id}/audiences", as: :json,
                                                     headers: authenticate_header(user)

      expect(response).to have_http_status(201)
      expect(parsed_body[:course_id]).to eq(course.id)
      expect(parsed_body[:user_id]).to eq(user.id)
      expect(user.courses.count).to eq(1)
    end

    it 'user cannot be part of same course audience' do
      user = create(:user)
      create(:audience, user: user, course: course)

      post "/api/v1/courses/#{course.id}/audiences", as: :json,
                                                     headers: authenticate_header(user)

      expect(response).to have_http_status(422)
      expect(parsed_body[:message]).to eq(
        'Validation failed: Course has already been taken'
      )
    end

    it 'should have ACCEPT header' do
      expect { post "/api/v1/courses/#{course.id}/audiences" }
        .to raise_error(ActionController::RoutingError)
    end

    it 'Only users logged in could access route' do
      post "/api/v1/courses/#{course.id}/audiences", as: :json

      expect(response).to have_http_status(401)
    end
  end
end
