# frozen_string_literal: true

require 'rails_helper'

describe 'Course Management' do
  context 'GET /api/v1/courses' do
    it 'should return courses' do
      create_list(:course, 3)

      get '/api/v1/courses', as: :json

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(3)
      expect(parsed_body.first.keys).to contain_exactly(
        :id, :title, :description, :created_at, :updated_at
      )
    end

    it 'should always return and array' do
      get '/api/v1/courses', as: :json

      expect(parsed_body).to eq([])
    end

    it 'should have ACCEPT header' do
      expect { get '/api/v1/courses' }
        .to raise_error(ActionController::RoutingError)
    end
  end
end
