# frozen_string_literal: true

require 'rails_helper'

describe 'User Management' do
  let(:admin) { create(:user, :admin) }
  context 'GET /api/v1/users' do
    it 'admins are not showed and exclude columns' do
      create_list(:user, 3)

      get '/api/v1/users', as: :json, headers: authenticate_header(admin)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body.count).to eq(3)
      expect(parsed_body.first.keys).to contain_exactly(
        :id, :email, :name, :created_at, :updated_at
      )
    end

    it 'should always return and array' do
      get '/api/v1/users', as: :json, headers: authenticate_header(admin)

      expect(parsed_body).to eq([])
    end

    it 'should have ACCEPT header' do
      expect { get '/api/v1/users' }
        .to raise_error(ActionController::RoutingError)
    end

    it 'Only users logged in could access route' do
      get '/api/v1/users', as: :json

      expect(response).to have_http_status(401)
    end

    it 'Only admins could access route' do
      get '/api/v1/users', as: :json, headers: authenticate_header

      expect(response).to have_http_status(403)
    end
  end

  context 'GET /api/v1/users/:id' do
    it 'should return a user' do
      user = create(:user, email: 'jane@bugle.com', name: 'Jane Doe')

      get "/api/v1/users/#{user.id}", as: :json,
                                      headers: authenticate_header(admin)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:id]).to eq(user.id)
      expect(parsed_body[:name]).to eq(user.name)
      expect(parsed_body[:email]).to eq(user.email)
    end

    it 'should return 404 if user does not exist' do
      get '/api/v1/users/000', as: :json, headers: authenticate_header(admin)

      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq(
        'User could not be found'
      )
    end

    it 'Only users logged in could access route' do
      user = create(:user, email: 'jane@bugle.com', name: 'Jane Doe')

      get "/api/v1/users/#{user.id}", as: :json

      expect(response).to have_http_status(401)
    end

    it 'Only admins could access route' do
      user = create(:user, email: 'jane@bugle.com', name: 'Jane Doe')

      get "/api/v1/users/#{user.id}", as: :json, headers: authenticate_header

      expect(response).to have_http_status(403)
    end
  end

  context 'POST /api/v1/users' do
    it 'should create a user' do
      user = attributes_for(:user)

      post '/api/v1/users', params: user, as: :json,
                            headers: authenticate_header(admin)

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:email]).to eq(user[:email])
      expect(parsed_body[:name]).to eq(user[:name])
    end

    it 'should return errors when user invalid' do
      post '/api/v1/users', params: { user: { something: '' } }, as: :json,
                            headers: authenticate_header(admin)

      expect(response).to have_http_status(422)
      expect(parsed_body[:message]).to include(
        "Validation failed: Email can't be blank, Password can't be blank, "\
        "Name can't be blank"
      )
    end

    it 'and email should be unique' do
      user = create(:user)
      post '/api/v1/users', params: attributes_for(:user, email: user.email),
                            as: :json, headers: authenticate_header(admin)

      expect(response).to have_http_status(422)
      expect(parsed_body[:message]).to eq(
        'Validation failed: Email has already been taken'
      )
    end

    it 'Only users logged in could access route' do
      user = attributes_for(:user)

      post '/api/v1/users', params: user, as: :json

      expect(response).to have_http_status(401)
    end

    it 'Only admins could access route' do
      user = attributes_for(:user)

      post '/api/v1/users', params: user, as: :json,
                            headers: authenticate_header

      expect(response).to have_http_status(403)
    end
  end
end
