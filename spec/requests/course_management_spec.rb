# frozen_string_literal: true

require 'rails_helper'

describe 'Course Management' do
  context 'GET /api/v1/courses' do
    it 'should return courses' do
      create_list(:course, 3)

      get '/api/v1/courses', as: :json, headers: authenticate_header

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(3)
      expect(parsed_body.first.keys).to contain_exactly(
        :id, :title, :description, :created_at, :updated_at
      )
    end

    it 'should always return and array' do
      get '/api/v1/courses', as: :json, headers: authenticate_header

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

      get "/api/v1/courses/#{course.id}", as: :json,
                                          headers: authenticate_header

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:id]).to eq(course.id)
      expect(parsed_body[:title]).to eq(course.title)
      expect(parsed_body[:description]).to eq(course.description)
    end

    it 'should return 404 if course does not exist' do
      get '/api/v1/courses/000', as: :json, headers: authenticate_header

      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq(
        'Course could not be found'
      )
    end
  end

  context 'POST /api/v1/courses' do
    it 'should create a course' do
      course = attributes_for(:course)

      post '/api/v1/courses', params: course, as: :json,
                              headers: authenticate_header

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:title]).to eq(course[:title])
      expect(parsed_body[:description]).to eq(course[:description])
    end

    it 'should return errors when course invalid' do
      post '/api/v1/courses', params: { course: { something: '' } }, as: :json,
                              headers: authenticate_header

      expect(response).to have_http_status(422)
      expect(parsed_body[:message]).to eq(
        "Validation failed: Title can't be blank, Description can't be blank"
      )
    end

    it 'should return errors when params not found' do
      post '/api/v1/courses', params: {}, as: :json,
                              headers: authenticate_header

      expect(response).to have_http_status(400)
      expect(parsed_body[:message]).to eq(
        'Parameters necessary for this request could not be found'
      )
    end
  end
end
