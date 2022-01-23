# frozen_string_literal: true

require 'rails_helper'

describe 'User Authentication' do
  context 'sign in' do
    it 'returns a token for api call' do
      user = create(:user)

      post '/api/sign_in',
           params: { email: user.email, password: user.password },
           as: :json

      expect(response).to have_http_status(200)
      expect(parsed_body[:token]).to be_present
    end

    it 'returns 404 when user not found' do
      post '/api/sign_in',
           params: { email: 'test@email.com', password: '123456' },
           as: :json

      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq('User could not be found')
    end
  end

  context 'signed in with token' do
    it 'access routes' do
      get '/api/v1/courses', as: :json, headers: authenticate_header
      expect(response).to have_http_status(200)
    end

    it 'without token get 401' do
      get '/api/v1/courses', as: :json
      expect(response).to have_http_status(401)
    end

    it 'with invalid token' do
      get '/api/v1/courses', as: :json, headers: { Authorization: 'abc' }
      expect(response).to have_http_status(401)
    end

    it 'with expired token' do
      user = create(:user)
      get '/api/v1/courses', as: :json,
                             headers: authenticate_header(user, 2.days.ago)
      expect(response).to have_http_status(401)
    end
  end
end
