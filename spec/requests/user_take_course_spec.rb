# frozen_string_literal: true

require 'rails_helper'

describe 'User take course' do
  context 'GET /api/v1/my-courses' do
    it 'can view course list' do
      user = create(:user)
      create_list(:audience, 3, user:)

      get '/api/v1/my-courses', as: :json, headers: authenticate_header(user)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(3)
      expect(parsed_body.first.keys).to contain_exactly(
        :id, :description, :title, :created_at, :updated_at
      )
    end

    it 'can only access his courses' do
      user = create(:user)
      create_list(:audience, 3)
      get '/api/v1/my-courses', as: :json, headers: authenticate_header(user)

      expect(parsed_body).to be_empty
    end

    it 'Only users logged in could access route' do
      get '/api/v1/my-courses', as: :json

      expect(response).to have_http_status(401)
    end
  end
end
