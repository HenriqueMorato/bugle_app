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
      create(:audience, user:, course:)

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

  context 'GET /api/v1/courses/:course_id/audiences' do
    it 'admin can view course audience' do
      admin = create(:user, :admin)
      create_list(:audience, 3, course:)

      get "/api/v1/courses/#{course.id}/audiences", as: :json,
                                                    headers: authenticate_header(admin)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(3)
      expect(parsed_body.first.keys).to contain_exactly(
        :id, :course_id, :user_id, :created_at, :updated_at
      )
    end

    it 'should always return and array' do
      admin = create(:user, :admin)
      get "/api/v1/courses/#{course.id}/audiences", as: :json,
                                                    headers: authenticate_header(admin)

      expect(parsed_body).to eq([])
    end

    it 'Only users logged in could access route' do
      get "/api/v1/courses/#{course.id}/audiences", as: :json

      expect(response).to have_http_status(401)
    end

    it 'Only admins could access route' do
      get "/api/v1/courses/#{course.id}/audiences", as: :json,
                                                    headers: authenticate_header

      expect(response).to have_http_status(403)
    end
  end
end
