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

  context 'GET /api/v1/courses/:id' do
    it 'should return a course' do
      course = create(:course, title: 'The Fellowship of the Course',
                               description: 'A good course to watch')

      get "/api/v1/courses/#{course.id}", as: :json

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:id]).to eq(course.id)
      expect(parsed_body[:title]).to eq(course.title)
      expect(parsed_body[:description]).to eq(course.description)
    end

    it 'should return 404 if course does not exist' do
      get "/api/v1/courses/000", as: :json

      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq(
        'Couldn\'t find Course with \'id\'=000'
      )
    end
  end
end
